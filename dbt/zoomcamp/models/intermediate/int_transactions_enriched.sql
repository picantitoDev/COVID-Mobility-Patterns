-- Enriquecimiento base de transacciones con atributos de producto y métricas financieras
with transactions as (
    select * from {{ ref('stg_transaction_data') }}
),

products as (
    select * from {{ ref('stg_product') }}
),

enriched as (
    select
        t.basket_id,
        t.transaction_day,
        t.week_number,
        t.household_id,
        t.store_id,
        t.transaction_time,
        
        -- IDs y métricas base
        t.product_id,
        t.quantity,
        t.sales_amount,
        
        -- Atributos del producto
        p.department_name,
        p.commodity_description,
        p.brand_type,
        
        -- Métricas financieras derivadas
        {{ calculate_total_discount(
            't.retailer_coupon_match_discount_amount', 
            't.manufacturer_coupon_discount_amount', 
            't.loyalty_discount_amount'
        ) }} as total_discount_amount

    from transactions t
    left join products p 
        on t.product_id = p.product_id
)

select * from enriched