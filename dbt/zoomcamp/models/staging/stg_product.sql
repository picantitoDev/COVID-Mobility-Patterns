/* Standardize product master data from the Dunnhumby source. */

with source as (

    select *
    from {{ source('dunnhumby', 'product') }}

),

renamed as (

    select
        cast(product_id as int64) as product_id,
        cast(manufacturer as int64) as manufacturer_id,
        lower(trim(department)) as department_name,
        lower(trim(brand)) as brand_type,
        lower(trim(commodity_desc)) as commodity_description,
        lower(trim(sub_commodity_desc)) as sub_commodity_description,
        trim(curr_size_of_product) as product_size

    from source

)

select * from renamed