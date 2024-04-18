CREATE OR REPLACE EXTERNAL TABLE `{{ env_var('GCP_PROJECT_ID') }}.product_hunt.product_hunt_products`
  OPTIONS (
    format ="PARQUET",
    uris = ["gs://{{ env_var('GCP_BUCKET_NAME') }}/product_hunt_data/product_hunt_products/*"]
);

CREATE OR REPLACE TABLE `{{ env_var('GCP_PROJECT_ID') }}.product_hunt.product_hunt_products_materialized`
PARTITION BY timestamp_trunc(release_date, MONTH)
AS SELECT * FROM `{{ env_var('GCP_PROJECT_ID') }}.product_hunt.product_hunt_products`;
