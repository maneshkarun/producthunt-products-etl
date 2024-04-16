{{
    config(
        materialized='table'
    )
}}


with producthunt_products as (
   select 
        products._id,
        products.name,
        products.product_description,
        products.upvotes,
        products.product_ranking,
        products.product_of_the_day_date,
        products.release_date,
        -- products.release_month,
        -- products.release_year,
        category.category_tags,
        products.last_updated
   from  
        {{ ref('dim_producthunt_products') }} as products inner join {{ ref('dim_producthunt_products_category') }} as category
        on  products._id =  category._id
)

select
    _id,
    name,
    product_description,
    upvotes,
    product_ranking,
    product_of_the_day_date,
    release_date,
    -- release_month,
    -- release_year,
    category_tags,
    last_updated,
    
from producthunt_products