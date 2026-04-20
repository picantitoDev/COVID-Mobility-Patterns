/* Create the household dimension table. */

{{ config(
    materialized='table',
    cluster_by=['income_range']
) }}

select
    household_id,
    age_range,
    marital_status_code,
    income_range,
    household_size_desc

from {{ ref('int_customer_behavior_aggregated') }}