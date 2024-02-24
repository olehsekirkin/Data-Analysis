import pandas as pd

# Specify the path to your original CSV file
original_csv_file = 'C:\\PATH\\Plant_2_Weather_Sensor_Data.csv'
# Specify the path where you want to save the modified CSV file
modified_csv_file = 'C:\\PATH\\Plant_2_Weather_Sensor_Data.csv'

# Read the original CSV file
df = pd.read_csv(original_csv_file)

# Adapt DATE_TIME so it fits the SQL requirements for loading data
df['DATE_TIME'] = pd.to_datetime(df['DATE_TIME'], format='%Y-%m-%d %H:%M:%S').dt.strftime('%Y-%m-%d')

# Save the modified DataFrame to a new CSV file
df.to_csv(modified_csv_file, index=False)

print(f"Modified CSV saved as: {modified_csv_file}")
