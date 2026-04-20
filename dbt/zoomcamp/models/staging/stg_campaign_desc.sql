/* Standardize campaign master data from the Dunnhumby source. */
with source as (

    select *
    from {{ source('dunnhumby', 'campaign_desc') }}

),

renamed as (

    select
        cast(campaign as int64) as campaign_id,
        trim(description) as campaign_type,
        cast(start_day as int64) as start_day,
        cast(end_day as int64) as end_day

    from source

)

select * from renamed