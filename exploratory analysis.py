import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sb

# Load all sheets from the Excel file
file_path = 'dataset.xlsx'
sheets = pd.read_excel(file_path, sheet_name=None)

# Extract each sheet
location_df = sheets['location']
traffic_df = sheets['traffic_flow']
congestion_df = sheets['congestion']
accident_df = sheets['accident_report']

# Quick view
print(location_df.head())
print(traffic_df.head())
print(congestion_df.head())
print(accident_df.head())

# Merge traffic with location
traffic_data = pd.merge(traffic_df, location_df, on='location_id', how='left')

# Merge congestion with location
congestion_data = pd.merge(congestion_df, location_df, on='location_id', how='left')

# Merge accident with location
accident_data = pd.merge(accident_df, location_df, on='location_id', how='left')

print(traffic_data.isnull().sum())
print(congestion_data.isnull().sum())
print(accident_data.isnull().sum())
