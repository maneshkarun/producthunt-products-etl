{{
    config(
        materialized='table'
    )
}}

select
    _id,
    name,
    category_tags
    
from {{ ref('stg_producthunt_product_category') }}
    