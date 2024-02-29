import pandas as pd

original_csv_file = 'C:\\PATH\\Plant_2_Weather_Sensor_Data.csv'
modified_csv_file = 'C:\\PATH\\Plant_2_Weather_Sensor_Data.csv'

df = pd.read_csv(original_csv_file)

df['DATE_TIME'] = pd.to_datetime(df['DATE_TIME'], format='%Y-%m-%d %H:%M:%S').dt.strftime('%Y-%m-%d')

df.to_csv(modified_csv_file, index=False)

print(f"Modified CSV saved as: {modified_csv_file}")
