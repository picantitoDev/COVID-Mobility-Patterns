/* Aggregate customer purchase behavior and enrich with household demographics. */

with transactions as (

    select *
    from {{ ref('int_transactions_enriched') }}

),

demographics as (

    select *
    from {{ ref('stg_hh_demographic') }}

),

customer_metrics as (

    select
        household_id,
        count(distinct basket_id) as total_baskets,
        sum(sales_amount) as total_spend,
        sum(quantity) as total_items_bought,
        sum(total_discount_amount) as total_discount_saved

    from transactions

    group by household_id

),

joined as (

    select
        c.household_id,
        c.total_baskets,
        c.total_spend,
        c.total_items_bought,
        c.total_discount_saved,

        d.age_range,
        d.marital_status_code,
        d.income_range,
        d.household_size_desc,

        {{ safe_divide('c.total_spend', 'c.total_baskets') }} as avg_basket_value

    from customer_metrics c
    left join demographics d
        on c.household_id = d.household_id

)

select * from joined