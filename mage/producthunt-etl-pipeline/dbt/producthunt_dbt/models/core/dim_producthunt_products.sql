{{
    config(
        materialized='table'
    )
}}

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
    main_image,
    websites,
    hunter,
    makers,
    last_updated

from {{ ref('stg_producthunt_products') }}
    