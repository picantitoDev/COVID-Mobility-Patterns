with source as (
    select * from {{ source('dunnhumby', 'coupon_redempt') }}
),

renamed as (
    select
        cast(household_key as int64) as household_id,
        cast(day as int64) as redemption_day,
        cast(coupon_upc as int64) as coupon_upc,
        cast(campaign as int64) as campaign_id
    from source
)

select * from renamed