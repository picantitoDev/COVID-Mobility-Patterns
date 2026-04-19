with source as (
    select * from {{ source('dunnhumby', 'transaction_data') }}
),

renamed as (
    select
        cast(household_key as int64) as household_id,
        cast(basket_id as int64) as basket_id,
        cast(day as int64) as transaction_day,
        cast(product_id as int64) as product_id,
        cast(quantity as int64) as quantity,
        cast(sales_value as float64) as sales_amount,
        cast(store_id as int64) as store_id,
        cast(coupon_match_disc as float64) as retailer_coupon_match_discount_amount,
        cast(coupon_disc as float64) as manufacturer_coupon_discount_amount,
        cast(retail_disc as float64) as loyalty_discount_amount,
        cast(trans_time as int64) as transaction_time,
        cast(week_no as int64) as week_number
    from source
)

select * from renamed