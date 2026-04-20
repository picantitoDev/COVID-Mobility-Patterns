/* Standardize household demographic data from the Dunnhumby source. */

with source as (

    select *
    from {{ source('dunnhumby', 'hh_demographic') }}

),

renamed as (

    select
        cast(household_key as int64) as household_id,
        trim(age_desc) as age_range,
        trim(marital_status_code) as marital_status_code,
        trim(income_desc) as income_range,
        trim(homeowner_desc) as homeowner_status,
        trim(hh_comp_desc) as household_composition,
        trim(household_size_desc) as household_size_desc,
        trim(kid_category_desc) as kids_category_desc

    from source

)

select * from renamed