{{
    config(
        materialized='view'
    )
}}

with producthunt_products_category as (
   select *
   from {{ source('staging', 'product_category_materialized') }}
   where _id is not null
)

select 
    {{ dbt.safe_cast("_id", api.Column.translate_type("string")) }} as _id,
    {{ dbt.safe_cast("name", api.Column.translate_type("string")) }} as name,
    {{ dbt.safe_cast("category_tags", api.Column.translate_type("string")) }} as category_tags
from producthunt_products_category
