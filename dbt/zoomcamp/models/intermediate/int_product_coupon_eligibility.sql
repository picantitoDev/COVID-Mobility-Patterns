/* Join coupon eligibility data with product and campaign attributes. */

with coupons as (

    select *
    from {{ ref('stg_coupon') }}

),

products as (

    select *
    from {{ ref('stg_product') }}

),

campaigns as (

    select *
    from {{ ref('stg_campaign_desc') }}

),

joined as (

    select
        c.coupon_upc,
        c.campaign_id,
        c.product_id,

        camp.campaign_type,
        camp.start_day as campaign_start_day,
        camp.end_day as campaign_end_day,

        p.department_name,
        p.commodity_description,
        p.brand_type

    from coupons c
    left join products p
        on c.product_id = p.product_id

    left join campaigns camp
        on c.campaign_id = camp.campaign_id

)

select * from joined