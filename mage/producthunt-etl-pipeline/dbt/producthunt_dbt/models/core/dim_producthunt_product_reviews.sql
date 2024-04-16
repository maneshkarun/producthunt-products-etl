{{
    config(
        materialized='table'
    )
}}

select
    _id,
    name,
    product_description,
    comments
    
from {{ ref('stg_producthunt_products') }}
    