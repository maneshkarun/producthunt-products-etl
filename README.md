# Product Hunt Data Extraction and Analysis Pipeline
## Quick Access
- [Product Hunt Data Extraction and Analysis Pipeline](#product-hunt-data-extraction-and-analysis-pipeline)
  - [Quick Access](#quick-access)
  - [Project description](#project-description)
  - [Dataset description](#dataset-description)
  - [Project Architecture](#project-architecture)
  - [Want to run the project?](#want-to-run-the-project)
    - [Pre-requisites](#pre-requisites)
      - [Getting the Kaggle API Key:](#getting-the-kaggle-api-key)
  - [Dashboard](#dashboard)
  - [Want to connect with me?](#want-to-connect-with-me)

## Project description
[Product Hunt](https://www.producthunt.com/about) is a platform that allows users to share and discover new products. It is a community-driven platform that allows users to upvote products they like and comment on them. The platform is a great way to discover new products and keep up with the latest trends in technology. 

This project is an end-to-end pipeline which is designed to extract data of products available on [producthunt.com](https://www.producthunt.com/) from [here](https://components.one/datasets/product-hunt-products), transform the data using dbt and store it in a data lake and data warehouse. The data is then visualized using Looker Studio. The project is divided into 4 main components
 
1. **Data Extraction**: The dataset can be downloaded from this [link](https://components.one/datasets/product-hunt-products)
2. **Data Transformation**: The data made available in BigQuery is transformed using dbt
3. **Data Storage**: The transformed data is stored in a datalake and DWH using Google Cloud Storage and BigQuery
4. **Data Visualization**: The data is visualized using Data Looker Studio

Welcome to the adventure of data exploration on Product Hunt. 👋

## Dataset description

The [dataset](https://components.one/datasets/product-hunt-products) includes 76,822 total products from year 2014-2021. It includes the following columns:

| Column Name               | Description                                                       | Type   |
|---------------------------|-------------------------------------------------------------------|--------|
| _id                       | the product page URL                                              | string |
| last_updated              | the most recent UTC datetime the row's values were updated        | string |
| name                      | the product's name                                                | string |
| product_description       | the short description of the product on its page                  | string |
| release_date              | the date the product was published to Product Hunt                | string |
| product_of_the_day_date   | the day the product received the Product of the Day distinction   | string |
| product_ranking           | the Product of the Day ranking it received, if applicable.        | string |
| main_image                | URL of the product image.                                         | string |
| upvotes                   | he number of upvotes received as of the last updated column       | string |
| websites                  | the product's website(s)                                          | string |
| category_tags             | the product's list of category tags                               | string |
| hunter                    | the username of the hunter                                        | string |
| makers                    | a list of the usersnames of the makers                            | string |
## Project Architecture
<p align="center">
    <img src="https://github.com/maneshkarun/producthunt-products-etl/blob/main/images/Producthunt-architecture.png"
      alt="Product Hunt Data Extraction and Analysis Pipeline Architecture"
      style="margin-right: 10px;">

## Want to run the project?
### Pre-requisites
- Docker
- Docker Compose
- [Google Cloud Platform Account]()
- [Terraform]()
- Kaggle API Key

#### Getting the Kaggle API Key:
1. Go to the [Kaggle](https://www.kaggle.com/) and sign in
2. Go to Settings > Account > API > Create New Token
3. Open the downloadeded file and copy the API key.


1. Clone the repository
```bash
git clone https://github.com/maneshkarun/producthunt-product-etl-pipeline.git
```
2. Run the terraform script
```bash
cd terraform
touch variables.tf
```
Make the following changes in the variables.tf file with your GCP project ID, BigQuery dataset name and GCS bucket name
```bash
variable "project" {
  description = "The project ID"
  default     = "<your-gcp-project-id>"
}

variable "bq_dataset_name" {
  description = "The BigQuery dataset name"
  default     = "<your-bq-dataset-name>"
}

variable "gcs_bucket_name" {
  description = "The GCS bucket name"
  default     = "<your-gcs-bucket-name>"
}
```
```bash
terraform init
terraform apply
```
3. Change the directory
```bash
cd ..
cd mage
```
Copy and Paste your google service account key file in the mage directory and rename it to `my-creds.json`
```bash
cp dev.env .env
rm dev.env
touch .env
```
Before spinning up the Docker containers, ensure you have set the following environment variables in the .env file
```bash
PROJECT_NAME=producthunt-etl-pipeline
GCP_PROJECT_ID=<enter your project id>
GCP_BUCKET_NAME=<enter your bucket name>
GOOGLE_APPLICATION_CREDENTIALS=/home/src/my-creds.json

# kaggle
KAGGLE_USERNAME=<enter your kaggle username>
KAGGLE_KEY=<enter your kaggle key>
```
4. Spin up the docker containers
```bash
docker-compose up -d
```
1. Open the browser and navigate to `http://localhost:6789` to access the Mage
2. Navigate to the `Pipelines` tab and click on the `producthunt_products_etl` pipeline > `Edit Pipeline`
3. In the right pane, click on the variables tab and edit the variable `gcs_filepath_products`
4. Change the value to `gs://<your-gcs-bucket-name>/product_hunt_data/product_hunt_products/*` modify with your GCS bucket name
5. Navigate to the `Pipeines` tab and click on the `producthunt_products_category_etl` pipeline
6. In the right pane, click on the variables tab and edit the variable `gcs_filepath_products_category`
7. Change the value to `gs://<your-gcs-bucket-name>/product_hunt_data/product_hunt_products_category/*` modify with your GCS bucket name
8. Go the `Pipelines` tab and click on the `producthunt_products_etl` pipeline > `Edit pipeline` and go to last leaf node block `trigger_category_pipeline` under more options, click `Execute with all upstream blocks`

This should also trigger the remaining two pipelines `producthunt_products_category_etl` and `dbt_transformation` automatically. Go back to dashboard and check the status of the pipelines.

This might take a while to complete. Once the pipelines are completed, you can check the data in the BigQuery and GCS bucket.

## Dashboard
<p align="center">
    <img src="

##  Want to connect with me?
- [LinkedIn](https://www.linkedin.com/in/manesh-karun/)