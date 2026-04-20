/* Create the customer metrics fact table. */

{{ config(
    materialized='table',
    cluster_by=['household_id']
) }}

select
    household_id,
    total_baskets,
    total_spend,
    total_items_bought,
    total_discount_saved,
    avg_basket_value

from {{ ref('int_customer_behavior_aggregated') }}