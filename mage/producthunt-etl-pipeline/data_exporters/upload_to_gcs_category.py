import pyarrow as pa
import pyarrow.parquet as pq
import os
from dotenv import main

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter
from mage_ai.data_preparation.variable_manager import set_global_variable


bucket_name = os.getenv('GCP_BUCKET_NAME')
project_id = os.getenv('GCP_PROJECT_ID')

folder_name = 'product_hunt_data'
table_name = f"{folder_name}/product_category"

root_path = f"{bucket_name}/{table_name}"

# gs_path =  f"gs://{root_path}/*"
# set_global_variable('producthunt_products_category_etl', 'gcs_filepath_products_category', gcs_path)

@data_exporter
def export_data(data, *args, **kwargs):
    table = pa.Table.from_pandas(data)
    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path=root_path,
        filesystem=gcs,
        use_deprecated_int96_timestamps=True
    )