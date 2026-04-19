{{ config(
    materialized='table',
    partition_by={
      "field": "redemption_date",
      "data_type": "date",
      "granularity": "day"
    },
    cluster_by=['campaign_id']
) }}

select
    household_id,
    campaign_id,
    coupon_upc,
    
    redemption_day,
    date_add(date '2022-01-01', interval cast(redemption_day as int64) - 1 day) as redemption_date,
    
    is_redeemed_in_window,
    1 as redemption_count -- Para facilitar sumas automáticas en el dashboard

from {{ ref('int_campaign_redemptions_joined') }}