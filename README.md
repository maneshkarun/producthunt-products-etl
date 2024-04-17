# Product Hunt Data Extraction and Analysis Pipeline
## Quick Access
- [Product Hunt Data Extraction and Analysis Pipeline](#product-hunt-data-extraction-and-analysis-pipeline)
  - [Quick Access](#quick-access)
  - [Project description](#project-description)
  - [Pipeline Architecture](#pipeline-architecture)
    - [1. **producthunt\_products\_etl**:](#1-producthunt_products_etl)
    - [2. **producthunt\_products\_category\_etl**:](#2-producthunt_products_category_etl)
    - [3. **dbt\_transformation**:](#3-dbt_transformation)
  - [Dataset description](#dataset-description)
  - [Project Architecture](#project-architecture)
  - [Want to run the project?](#want-to-run-the-project)
    - [Pre-requisites](#pre-requisites)
      - [1. Setup your GCP Account](#1-setup-your-gcp-account)
      - [2. Docker Installation](#2-docker-installation)
      - [3. Terraform Installation](#3-terraform-installation)
      - [4. Generate Kaggle API Key:](#4-generate-kaggle-api-key)
    - [Steps to run the project](#steps-to-run-the-project)
      - [1. Clone the repository](#1-clone-the-repository)
      - [2. Modify variables.tf \& run the terraform script](#2-modify-variablestf--run-the-terraform-script)
      - [3. Modify the .env file and run the docker-compose file of Mage](#3-modify-the-env-file-and-run-the-docker-compose-file-of-mage)
      - [4. Spin up the docker containers](#4-spin-up-the-docker-containers)
      - [5. DBT](#5-dbt)
  - [Dashboard](#dashboard)

## Project description
[Product Hunt](https://www.producthunt.com/about) is a platform that allows users to share and discover new products. It is a community-driven platform that allows users to upvote products they like and comment on them. The platform is a great way to discover new products and keep up with the latest trends in technology. 

This project is an end-to-end pipeline which is designed to extract data of products available on [producthunt.com](https://www.producthunt.com/) from Kaggle, store it in GCS, load the data into BigQuery from GCS, transform the data using dbt and store it again in BigQuery. The data is then visualized using Looker Studio. The project is divided into 4 main components
 
1. **Data Extraction**: The [dataset](https://www.kaggle.com/datasets/maneshkarun/producthunt-products-dataset-2014-2021) is downloaded using Kaggle API
2. **Data Storage**: The data is stored in GCS and later loaded into BigQuery
3. **Data Transformation**: The data made available in BigQuery is transformed using dbt and stored in BigQuery
4. **Data Visualization**: The data is then visualized using Data Looker Studio

Welcome to the adventure of data exploration on Product Hunt. 👋

## Pipeline Architecture
- There are three pipelines in this project
### 1. **producthunt_products_etl**:
<p align="center">
    <img src="https://github.com/maneshkarun/producthunt-products-etl/blob/main/images/producthunt_products_etl.png"
      alt="Producthunt Products ETL Pipeline Architecture"
      style="margin-right: 10px;">

- This pipeline is responsible for extracting the data from Kaggle and store it locally, upload to GCS, loading the data into BigQuery, and triggering the next pipeline (producthunt_products_category_etl)

### 2. **producthunt_products_category_etl**: 
<p align="center">
    <img src="https://github.com/maneshkarun/producthunt-products-etl/blob/main/images/producthunt_products_category_etl.png"
      alt="Producthunt Products ETL Pipeline Architecture"
      style="margin-right: 10px;">

- This pipeline is responsible for extratcing the category_tags column along with _id and name. Explode the category_tags column to normalize the dataset and store it in GCS, load the data into BigQuery, and trigger the next pipeline (dbt_transformation)

### 3. **dbt_transformation**: 
<p align="center">
    <img src="https://github.com/maneshkarun/producthunt-products-etl/blob/main/images/dbt_transformation.png"
      alt="Product Hunt Data Extraction and Analysis Pipeline Architecture"
      style="margin-right: 10px;">

- This pipeline is responsible for transforming the data using dbt and storing it in BigQuery
      
## Dataset description

The [dataset](https://www.kaggle.com/datasets/maneshkarun/producthunt-products-dataset-2014-2021) includes 76,822 total products from year 2014-2021. It includes the following columns:

| Column Name               | Description                                                       | Type     |
|---------------------------|-------------------------------------------------------------------|----------|
| _id                       | the product page URL                                              | string   |
| last_updated              | the most recent UTC datetime the row's values were updated        | datetime |
| name                      | the product's name                                                | string   |
| product_description       | the short description of the product on its page                  | string   |
| release_date              | the date the product was published to Product Hunt                | datetime |
| product_of_the_day_date   | the day the product received the Product of the Day distinction   | datetime |
| product_ranking           | the Product of the Day ranking it received, if applicable.        | integer  |
| main_image                | URL of the product image.                                         | string   |
| upvotes                   | he number of upvotes received as of the last updated column       | integer  |
| websites                  | the product's website(s)                                          | string   |
| category_tags             | the product's list of category tags                               | string   |
| hunter                    | the username of the hunter                                        | string   |
| makers                    | a list of the usersnames of the makers                            | string   |

## Project Architecture
<p align="center">
    <img src="https://github.com/maneshkarun/producthunt-products-etl/blob/main/images/Producthunt-architecture.png"
      alt="Product Hunt Data Extraction and Analysis Pipeline Architecture"
      style="margin-right: 10px;">

## Want to run the project?
### Pre-requisites

#### 1. Setup your GCP Account
#### 2. Docker Installation
#### 3. Terraform Installation
#### 4. Generate Kaggle API Key:
- Go to the [Kaggle](https://www.kaggle.com/) and sign in
- Go to Settings > Account > API > Create New Token
- Open the downloadeded file and copy the API key and username.
  
### Steps to run the project

#### 1. Clone the repository
```bash
git clone https://github.com/maneshkarun/producthunt-product-etl-pipeline.git
```
#### 2. Modify variables.tf & run the terraform script
```bash
cd terraform
nano variables.tf
```
- Make the following changes in the variables of the `variables.tf` file
  - `project_id` - enter your GCP project id
  - `gcs_bucket_name` - enter your GCS bucket name
  
**I recommend you not to change the default value of `bq_dataset_name`. If you want to change, please make sure to modify the SQL queries of data exporter blocks and schema.yml of the dbt model inside Mage to represent the same.**
```bash
terraform init
terraform plan
terraform apply
```
#### 3. Modify the .env file and run the docker-compose file of Mage
```bash
cd ..
cd mage
```
- Copy and paste your google service account key file inside the mage directory and rename it to `my-creds.json`
```bash
cp dev.env .env
rm dev.env
nano .env
```
Before spinning up the Docker containers, ensure you have set the following environment variables in the .env file

  - `GCP_PROJECT_ID=<enter your GCP project id>`
  - `GCP_BUCKET_NAME=<enter your GCS bucket name>`
  - `KAGGLE_USERNAME=<enter your kaggle username>`
  - `KAGGLE_KEY=<enter your kaggle key>`

#### 4. Spin up the docker containers
```bash
docker-compose up -d
```
- Access the Mage UI
  - Open the browser and navigate to `http://localhost:6789` to access the Mage
  - Navigate to the `Pipelines` tab and click on the `producthunt_products_etl` pipeline > `Edit Pipeline`
  - In the right pane, click on the variables tab and edit the variable `gcs_filepath_products`
  - Change the value to `gs://<your-gcs-bucket-name>/product_hunt_data/product_hunt_products/*` modify with your GCS bucket name. Make sure that the value of the variable is enclosed in quotes.
  - Navigate to the `Pipeines` tab and click on the `producthunt_products_category_etl` pipeline
  - In the right pane, click on the variables tab and edit the variable `gcs_filepath_products_category`
  - Change the value to `gs://<your-gcs-bucket-name>/product_hunt_data/product_hunt_products_category/*` modify with your GCS bucket name. Make sure that the value of the variable is enclosed in quotes.
  - Go the `Pipelines` tab and click on the `producthunt_products_etl` pipeline > `Edit pipeline` and go to last node of the pipeline `trigger_category_pipeline` under more options, click `Execute with all upstream blocks`

This should also trigger the remaining two pipelines `producthunt_products_category_etl` and `dbt_transformation` automatically. Go back to dashboard and check the status of the pipelines.

This might take a while to complete [~ 10 mins]. Once the pipelines are completed, you can check the data in the BigQuery and GCS bucket.

- **Folder name in GCS bucket**: `product_hunt_data`
- **BigQuery Dataset**: `product_hunt`

#### 5. DBT
- Transformed tables can be found in the BigQuery dataset `dbt_producthunt`

Feel free to explore the models created in the dbt project. You can find the dbt project in the `producthunt-etl-pipeline` > `dbt` > `producthunt_dbt` directory inside Mage.

## Dashboard
Checkout the Looker dashboard [here](https://lookerstudio.google.com/s/sR6g0Zjlzpg)
<p align="center">
    <img src="