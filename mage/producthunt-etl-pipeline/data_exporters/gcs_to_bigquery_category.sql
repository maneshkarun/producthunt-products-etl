CREATE OR REPLACE EXTERNAL TABLE `{{ env_var('GCP_PROJECT_ID') }}.product_hunt.product_category`
  OPTIONS (
    format ="PARQUET",
    uris = ["gs://{{ env_var('GCP_BUCKET_NAME') }}/product_hunt_data/product_category/*"]
);

CREATE OR REPLACE TABLE `{{ env_var('GCP_PROJECT_ID') }}.product_hunt.product_category_materialized`
AS SELECT * FROM `{{ env_var('GCP_PROJECT_ID') }}.product_hunt.product_category`;