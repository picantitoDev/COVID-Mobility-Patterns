{{ config(materialized='table') }}

-- Dimensión de fecha generada a partir de los días únicos de transacciones
with distinct_days as (
    select distinct transaction_day as day_number
    from {{ ref('int_transactions_enriched') }}
)

select
    day_number,
    -- Convertimos el entero a una FECHA REAL para que Looker/BI pueda agrupar por mes/año
    date_add(date '2022-01-01', interval cast(day_number as int64) - 1 day) as calendar_date,
    extract(year from date_add(date '2022-01-01', interval cast(day_number as int64) - 1 day)) as calendar_year,
    extract(month from date_add(date '2022-01-01', interval cast(day_number as int64) - 1 day)) as calendar_month,
    extract(dayofweek from date_add(date '2022-01-01', interval cast(day_number as int64) - 1 day)) as day_of_week
from distinct_days