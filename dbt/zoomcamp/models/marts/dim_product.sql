/* Create the product dimension table. */

{{ config(materialized='table') }}

select distinct
    product_id,
    department_name,
    commodity_description,
    brand_type

from {{ ref('int_transactions_enriched') }}