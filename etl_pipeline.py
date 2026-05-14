import pandas as pd
import numpy as np
import logging
import os
from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

# -----------------------------------
# Logging Configuration
# -----------------------------------

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)

# -----------------------------------
# Extract
# -----------------------------------

def extract(file_path):

    logging.info(f"Starting extraction from {file_path}")

    data = pd.read_csv(file_path)

    logging.info(
        f"Loaded {data.shape[0]} rows and {data.shape[1]} columns"
    )

    logging.info(f"Columns: {list(data.columns)}")

    return data

# -----------------------------------
# Cleaning Functions
# -----------------------------------

def clean_column_headers(data):

    data.columns = (
        data.columns
        .str.strip()
        .str.lower()
        .str.replace(" ", "_")
    )

    data = data.loc[:, ~data.columns.duplicated()]

    logging.info("Column headers cleaned and duplicates removed")

    return data


def clean_currency_column(data):

    data['spend'] = (
        data['spend']
        .astype(str)
        .str.replace(r'[^\d.-]', '', regex=True)
    )

    data['spend'] = pd.to_numeric(
        data['spend'],
        errors='coerce'
    )

    logging.info(
        f"Spend column cleaned. Null values: "
        f"{data['spend'].isnull().sum()}"
    )

    return data


def clean_categorical_values(data):

    cleanup_map = {
        'Facebok': 'Facebook',
        'Insta_gram': 'Instagram',
        'Gogle': 'Google Ads',
        'Tik_Tok': 'TikTok',
        'E-mail': 'Email',
        'N/A': np.nan
    }

    data['channel'] = data['channel'].replace(cleanup_map)

    logging.info("Categorical values standardized")

    return data


def clean_boolean_values(data):

    boolean_map = {
        'Y': True,
        'Yes': True,
        '1': True,
        1: True,
        'No': False,
        '0': False,
        0: False
    }

    data['active'] = (
        data['active']
        .map(boolean_map)
        .fillna(False)
        .astype(bool)
    )

    logging.info("Boolean values cleaned")

    return data


def clean_dates(data):

    data['start_date'] = pd.to_datetime(
        data['start_date'],
        errors='coerce'
    )

    data['end_date'] = pd.to_datetime(
        data['end_date'],
        dayfirst=True,
        errors='coerce'
    )

    logging.info("Date parsing completed")

    return data

# -----------------------------------
# Validation Functions
# -----------------------------------

def validate_date_logic(data):

    time_mask = data['end_date'] < data['start_date']

    data.loc[
        time_mask,
        'end_date'
    ] = data.loc[
        time_mask,
        'start_date'
    ] + pd.Timedelta(days=30)

    logging.info(
        "Date validation applied for incorrect end dates"
    )

    return data


def handle_outliers(data):

    q1 = data['spend'].quantile(0.25)
    q3 = data['spend'].quantile(0.75)

    iqr = q3 - q1

    upper_limit = q3 + (3 * iqr)

    outlier_mask = data['spend'] > upper_limit

    data.loc[outlier_mask, 'spend'] = upper_limit

    logging.info("Spend outliers capped")

    return data

# -----------------------------------
# Feature Engineering
# -----------------------------------

def create_derived_columns(data):

    data['season'] = data['campaign_name'].str.extract(
        r'Q\d_([^_]+)_'
    )

    logging.info("Derived columns created")

    return data

# -----------------------------------
# Transformation Pipeline
# -----------------------------------

def transform(data):

    logging.info("Starting transformation phase")

    data = clean_column_headers(data)

    data = clean_currency_column(data)

    data = clean_categorical_values(data)

    data = clean_boolean_values(data)

    data = clean_dates(data)

    data = validate_date_logic(data)

    data = handle_outliers(data)

    data = create_derived_columns(data)

    logging.info("Transformation completed")

    return data

# -----------------------------------
# Load
# -----------------------------------

def load(data):

    engine = create_engine(
        f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    )

    # Raw staging table
    data.to_sql(
        name='raw_campaigns',
        con=engine,
        if_exists='replace',
        index=False
    )

    logging.info("Data loaded into PostgreSQL")

    # Validation after load
    loaded_data = pd.read_sql(
        "SELECT * FROM raw_campaigns",
        con=engine
    )

    try:

        assert data.shape == loaded_data.shape

        logging.info(
            "Load validation successful"
        )

    except AssertionError:

        logging.error(
            "Load validation failed: shape mismatch"
        )
    finally:
        engine.dispose()

# -----------------------------------
# Main Pipeline
# -----------------------------------

def main():

    file_path = "data/marketing_campaign.csv"

    data = extract(file_path)

    data = transform(data)

    load(data)

    logging.info("ETL Pipeline executed successfully")


if __name__ == "__main__":

    main()