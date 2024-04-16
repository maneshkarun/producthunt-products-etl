import    pandas as pd
if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

from ast import literal_eval

@transformer
def transform(data, *args, **kwargs):
    category_df = pd.DataFrame(data=data[['_id', 'name','category_tags']], columns=['_id', 'name','category_tags'])
    category_df['category_tags'] = category_df['category_tags'].apply(literal_eval)
    category_normalized = category_df.explode('category_tags')
    return category_normalized

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'