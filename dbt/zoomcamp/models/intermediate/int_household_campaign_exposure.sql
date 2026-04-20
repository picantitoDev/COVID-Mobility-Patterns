/* Join household campaign exposure data with campaign and demographic attributes. */

with household_campaigns as (

    select *
    from {{ ref('stg_campaign_table') }}

),

campaign_details as (

    select *
    from {{ ref('stg_campaign_desc') }}

),

demographics as (

    select *
    from {{ ref('stg_hh_demographic') }}

),

joined as (

    select
        hc.household_id,
        hc.campaign_id,

        cd.campaign_type,
        cd.start_day,
        cd.end_day,

        d.age_range,
        d.income_range,
        d.marital_status_code

    from household_campaigns hc
    left join campaign_details cd
        on hc.campaign_id = cd.campaign_id

    left join demographics d
        on hc.household_id = d.household_id

)

select * from joined