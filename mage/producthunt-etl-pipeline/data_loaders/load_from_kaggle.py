from mage_ai.io.file import FileIO
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

import os
import pandas as pd
from kaggle.api.kaggle_api_extended import KaggleApi

@data_loader
def load_data_from_file(*args, **kwargs):

    api = KaggleApi()
    api.authenticate()
    api.dataset_download_files('maneshkarun/producthunt-products-dataset-2014-2021', path=".", unzip=True)
    filepath = 'product-hunt-prouducts-1-1-2014-to-12-31-2021.csv'

    df_dtype = {
                    '_id': str,
                    'name': str,
                    'product_description': str,
                    'product_ranking':pd.Int64Dtype(),
                    'main_image':str,
                    'images': str,
                    'upvotes': pd.Int64Dtype(),
                    'comments':str,
                    'websites':str,
                    'category_tags':str,
                    'hunter':str,
                    'makers':str
                }
    parse_dates = ['release_date','product_of_the_day_date','last_updated']

    df = pd.read_csv(filepath, dtype=df_dtype, parse_dates=parse_dates)
    kwargs['df'] = df
    return df
@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'