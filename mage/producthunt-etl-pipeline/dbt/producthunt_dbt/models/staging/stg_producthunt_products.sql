{{
    config(
        materialized='view'
    )
}}

with producthunt_products as (
   select *
   from {{ source('staging', 'product_hunt_products_materialized') }}
   where _id is not null
)

select
    {{ dbt.safe_cast("_id", api.Column.translate_type("string")) }} as _id,
    {{ dbt.safe_cast("name", api.Column.translate_type("string")) }} as name,
    {{ dbt.safe_cast("product_description", api.Column.translate_type("string")) }} as product_description,
    {{ dbt.safe_cast("upvotes", api.Column.translate_type("integer")) }} as upvotes,
    {{ dbt.safe_cast("product_ranking", api.Column.translate_type("integer")) }} as product_ranking,
    {{ dbt.safe_cast("main_image", api.Column.translate_type("string")) }} as main_image,
    {{ dbt.safe_cast("images", api.Column.translate_type("string")) }} as images,
    {{ dbt.safe_cast("comments", api.Column.translate_type("string")) }} as comments,
    {{ dbt.safe_cast("websites", api.Column.translate_type("string")) }} as websites,
    {{ dbt.safe_cast("category_tags", api.Column.translate_type("string")) }} as category_tags,
    {{ dbt.safe_cast("hunter", api.Column.translate_type("string")) }} as hunter,
    {{ dbt.safe_cast("makers", api.Column.translate_type("string")) }} as makers,
    cast(last_updated as timestamp) as last_updated,
    cast(release_date as timestamp) as release_date,
    cast(product_of_the_day_date as timestamp) as product_of_the_day_date,
    -- date_part('month', release_date) as release_month,
    -- date_part('year', release_date) as release_year,

    from producthunt_products
