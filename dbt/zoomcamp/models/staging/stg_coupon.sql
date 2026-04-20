/* Standardize coupon-to-product mapping data from the Dunnhumby source. */

with source as (

    select *
    from {{ source('dunnhumby', 'coupon') }}

),

renamed as (

    select
        cast(campaign as int64) as campaign_id,
        cast(coupon_upc as int64) as coupon_upc,
        cast(product_id as int64) as product_id

    from source

)

select * from renamed