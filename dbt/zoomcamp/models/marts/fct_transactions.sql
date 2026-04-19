{{ config(
    materialized='table',
    partition_by={
      "field": "transaction_date",
      "data_type": "date",
      "granularity": "day"
    },
    cluster_by=['department_name', 'household_id']
) }}

with transactions as (
    select * from {{ ref('int_promotions_enriched') }}
)

select
    -- Primary & Foreign Keys
    basket_id,
    product_id,
    household_id,
    store_id,
    
    -- Manejo de Tiempo
    transaction_day,
    date_add(date '2022-01-01', interval cast(transaction_day as int64) - 1 day) as transaction_date,
    transaction_time,

    -- Métricas (Hechos)
    quantity,
    sales_amount,
    total_discount_amount,
    (sales_amount - coalesce(total_discount_amount, 0)) as net_sales,

    -- Denormalización táctica (Para gráficos de barras inmediatos en Looker sin hacer JOINs extra)
    department_name,
    is_on_display,
    is_in_mailer

from transactions