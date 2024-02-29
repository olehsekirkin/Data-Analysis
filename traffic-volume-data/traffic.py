# Part 1. Data transformation and visualization.

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import datetime

pd.set_option('display.max_colwidth', None)
pd.set_option('display.width', None)

data = pd.read_csv('C:\\Users\\olehs\\Desktop\Metro_Interstate_Traffic_Volume.csv', parse_dates=[7])

if len(data.dropna() == len(data)):
    print('No missing values')
else:
    print('Missing values')

print(data.describe())

data_clean1 = data.loc[data['temp']>=222]

data_clean2 = data_clean1.loc[data_clean1['rain_1h']<=383]
print(data_clean2.describe())

data_clean2['date_time_year'] = pd.DatetimeIndex(data_clean2['date_time']).year
data_clean2['date_time_month'] = pd.DatetimeIndex(data_clean2['date_time']).month
data_clean2['date_time_time'] = pd.DatetimeIndex(data_clean2['date_time']).time
data_clean2['date_time_year'] = data_clean2['date_time_year'].apply(lambda x: int(x))
data_clean2['date_time_month'] = data_clean2['date_time_month'].apply(lambda x: int(x))
data_clean2['date_time_time'] = data_clean2['date_time_time'].apply(lambda x: x.hour * 3600)

data_shrunk = data_clean2.iloc[: round(len(data_clean2)/2) , :]

plt.figure(figsize=(18, 18))

plt.subplot(2, 2, 1)
plt.xlim(min(data_shrunk['temp']), max(data_shrunk['temp']))
plt.hist(data_shrunk['temp'])
plt.title('Distribution of Dates')

plt.subplot(2, 2, 2)
plt.hist(data_shrunk['date_time'], bins=(len(pd.to_datetime(data_shrunk['date_time']).dt.to_period('M').groupby(pd.to_datetime(data_shrunk['date_time']).dt.to_period('M')).count())))
plt.title('Distribution of Dates')

plt.subplot(2, 2, 3)
plt.hist(data_shrunk['rain_1h'])
plt.title('Disbution of Rain in an Hour')

plt.subplot(2, 2, 4)
plt.hist(data_shrunk['snow_1h'])
plt.title('Distribution of Snow in an Hour')

plt.show()

holiday_data = data_clean2.groupby('holiday').traffic_volume.sum().reset_index()
weather_data = data_clean2.groupby('weather_main').traffic_volume.sum().reset_index()
cloud_data = data_clean2.groupby('clouds_all').traffic_volume.sum().reset_index()

plt.figure(figsize=(15, 18))

plt.subplot(3, 2, 1)
plt.scatter(data_shrunk['temp'], data_shrunk['traffic_volume'], alpha=0.1)
plt.title('Temp vs Traffic')
plt.xlabel('Temp')
plt.ylabel('Traffic')

plt.subplot(3, 2, 2)
plt.scatter(data_shrunk['rain_1h'], data_shrunk['traffic_volume'], alpha=0.1)
plt.title('Rain vs Traffic')
plt.xlabel('Rain 1 Hour')
plt.ylabel('Traffic')

plt.subplot(3, 2, 3)
plt.scatter(data_shrunk['snow_1h'], data_shrunk['traffic_volume'], alpha=0.1)
plt.title('Snow vs Traffic')
plt.xlabel('Snow')
plt.ylabel('Traffic')

plt.subplot(3, 2, 4)
plt.bar(range(len(cloud_data)), cloud_data['traffic_volume'])
plt.title('Clouds vs Traffic')
plt.xlabel('Cloud Cover')
plt.ylabel('Traffic')
plt.subplot(3, 2, 4).set_xticks([i*5 for i in range(21)])

plt.subplot(3, 2, 5)
plt.bar(range(len(weather_data)), weather_data['traffic_volume'])
plt.title('Weather vs Traffic')
plt.xlabel('Weather Main')
plt.ylabel('Traffic')
plt.subplot(3, 2, 5).set_xticks(range(len(weather_data)))
plt.subplot(3, 2, 5).set_xticklabels(weather_data['weather_main'])
plt.xticks(rotation=45)

plt.subplot(3, 2, 6)
plt.bar(range(len(holiday_data)), holiday_data['traffic_volume'])
plt.title('Holidays vs Traffic')
plt.xlabel('Holidays')
plt.ylabel('Traffic')
plt.subplot(3, 2, 6).set_xticks(range(len(holiday_data)))
plt.subplot(3, 2, 6).set_xticklabels(holiday_data['holiday'])
plt.xticks(rotation=60)

plt.show()

# Part 2. Traffic prediction.

x = data_clean2.loc[:, ['holiday', 'weather_main', 'temp', 'rain_1h', 'snow_1h', 'clouds_all', 'date_time_year', 'date_time_month', 'date_time_time']].values
y = data_clean2.loc[:, ['traffic_volume']].values

from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder

ct = ColumnTransformer(transformers=[('encoder', OneHotEncoder(), [0, 1])], remainder='passthrough')

x_encoded = np.array(ct.fit_transform(x))

from sklearn.model_selection import train_test_split
x_train, x_test, y_train, y_test = train_test_split(x_encoded, y, test_size=0.2, random_state=0)

from sklearn.preprocessing import StandardScaler
scx = StandardScaler()
scy = StandardScaler()

x_train_scaled = x_train
x_test_scaled = x_test

x_train_scaled[:, 23:] = scx.fit_transform(x_train[:, 23:])
x_test_scaled[:, 23:] = scx.transform(x_test[:, 23:])

y_train_scaled = scy.fit_transform(y_train)
y_test_scaled = scy.transform(y_test)

# Multiple Linear Regression

from sklearn.linear_model import LinearRegression

regressor_lin = LinearRegression()
regressor_lin.fit(x_train, y_train)

y_lin_pred = regressor_lin.predict(x_test)

# Support Vector Machine Regression

from sklearn.svm import SVR
regressor_svr = SVR(kernel='rbf')
regressor_svr.fit(x_train_scaled, y_train_scaled)
y_svr_pred = regressor_svr.predict(x_test_scaled)

# Decision Tree Regression

from sklearn.tree import DecisionTreeRegressor

regression_tree = DecisionTreeRegressor(random_state=0)
regression_tree.fit(x_train, y_train)

y_dectree_pred = regression_tree.predict(x_test)

# Random Forest Regressor

from sklearn.ensemble import RandomForestRegressor

rndm_frst = RandomForestRegressor(n_estimators=10, random_state=0)
rndm_frst.fit(x_train, y_train)

y_rndmfrst_pred = rndm_frst.predict(x_test)

# Results

from sklearn.metrics import r2_score
results_dictionary = {'Model':['Multi Linear Regression', 'SVR', 'Decision Tree', 'Random Forest'], 'R2': [r2_score(y_test, y_lin_pred), r2_score(y_test_scaled, y_svr_pred), r2_score(y_test, y_dectree_pred), r2_score(y_test, y_rndmfrst_pred)]}

results_df = pd.DataFrame(results_dictionary)
print(results_df)

plt.figure(figsize=(12, 12))
plt.subplot(2, 2, 1)
plt.scatter(y_test, y_lin_pred)
plt.plot(np.arange(0, max(y_test), 1), color='black')
plt.xlabel('Test Y Values')
plt.ylabel('Predicted Y Values')
plt.title("Multi Linear Regression")

plt.subplot(2, 2, 2)
plt.scatter(y_test_scaled, y_svr_pred, color='red')
plt.plot(np.arange(-1.5, 2.0, 0.1), np.arange(-1.5, 2.0, 0.1), color='black')
plt.xlabel('Scaled Test Y Values')
plt.ylabel('Scaled Predicted Y Values')
plt.title("Support Vector Machine Regression")

plt.subplot(2, 2, 3)
plt.scatter(y_test, y_dectree_pred, color='green')
plt.plot(np.arange(0, max(y_test), 1), color='black')
plt.xlabel('Test Y Values')
plt.ylabel('Predicted Y Values')
plt.title("Decision Tree Regression")

plt.subplot(2, 2, 4)
plt.scatter(y_test, y_rndmfrst_pred, color='purple')
plt.plot(np.arange(0, max(y_test), 1), color='black')
plt.xlabel('Test Y Values')
plt.ylabel('Predicted Y Values')
plt.title("Random Forest Regression")

plt.show()
