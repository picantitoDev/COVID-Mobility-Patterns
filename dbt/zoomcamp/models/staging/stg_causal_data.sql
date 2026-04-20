/* Standardize promotional causal data from the Dunnhumby source. */

with source as (

    select *
    from {{ source('dunnhumby', 'causal_data') }}

),

renamed as (

    select
        cast(product_id as int64) as product_id,
        cast(store_id as int64) as store_id,
        cast(week_no as int64) as week_number,
        trim(display) as display_location_code,
        trim(mailer) as mailer_location_code

    from source

)

select * from renamed