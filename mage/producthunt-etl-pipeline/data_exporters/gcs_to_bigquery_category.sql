CREATE OR REPLACE EXTERNAL TABLE `evident-time-410307.product_hunt.product_category`
  OPTIONS (
    format ="PARQUET",
    uris = ["gs://evident-time-410307-example-bucket/product_hunt_data/product_category/*"]
);

CREATE OR REPLACE TABLE `evident-time-410307.product_hunt.product_category_materialized`
AS SELECT * FROM `evident-time-410307.product_hunt.product_category`;