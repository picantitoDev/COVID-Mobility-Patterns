/* Join coupon redemptions with campaign metadata and validate redemption timing. */

with redemptions as (

    select *
    from {{ ref('stg_coupon_redempt') }}

),

campaigns as (

    select *
    from {{ ref('stg_campaign_desc') }}

),

joined as (

    select
        r.household_id,
        r.redemption_day,
        r.coupon_upc,
        r.campaign_id,

        c.campaign_type,
        c.start_day,
        c.end_day,

        case
            when r.redemption_day between c.start_day and c.end_day then true
            else false
        end as is_redeemed_in_window

    from redemptions r
    left join campaigns c
        on r.campaign_id = c.campaign_id

)

select * from joined