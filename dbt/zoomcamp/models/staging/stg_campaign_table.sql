/* Standardize household campaign participation data from the Dunnhumby source. */

with source as (

    select *
    from {{ source('dunnhumby', 'campaign_table') }}

),

renamed as (

    select
        cast(household_key as int64) as household_id,
        cast(campaign as int64) as campaign_id,
        trim(description) as campaign_type

    from source

)

select * from renamed