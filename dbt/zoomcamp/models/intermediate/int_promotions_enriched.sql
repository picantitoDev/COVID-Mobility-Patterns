/* Enrich transactions with in-store promotional causal data. */

with enriched_transactions as (

    select *
    from {{ ref('int_transactions_enriched') }}

),

causal_data as (

    select *
    from {{ ref('stg_causal_data') }}

),

joined as (

    select
        t.*,
        c.display_location_code,
        c.mailer_location_code,

        {{ get_promotion_flag('c.display_location_code') }} as is_on_display,
        {{ get_promotion_flag('c.mailer_location_code') }} as is_in_mailer

    from enriched_transactions t

    left join causal_data c
        on t.product_id = c.product_id
       and t.store_id = c.store_id
       and t.week_number = c.week_number

)

select * from joined