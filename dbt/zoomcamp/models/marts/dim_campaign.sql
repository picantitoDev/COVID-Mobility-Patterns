{{ config(materialized='table') }}

select distinct
    campaign_id,
    campaign_type,
    start_day,
    end_day,
    date_add(date '2022-01-01', interval cast(start_day as int64) - 1 day) as campaign_start_date,
    date_add(date '2022-01-01', interval cast(end_day as int64) - 1 day) as campaign_end_date
from {{ ref('int_household_campaign_exposure') }}