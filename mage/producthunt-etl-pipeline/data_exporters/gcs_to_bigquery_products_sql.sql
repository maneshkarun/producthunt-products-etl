CREATE OR REPLACE EXTERNAL TABLE `evident-time-410307.product_hunt_test.product_hunt_products`
  OPTIONS (
    format ="PARQUET",
    uris = ['gs://evident-time-410307-example-bucket/product_hunt_data_test/product_hunt_products/*']
);

CREATE OR REPLACE TABLE `evident-time-410307.product_hunt_test.product_hunt_products_materialized`
AS SELECT * FROM `evident-time-410307.product_hunt_test.product_hunt_products`;