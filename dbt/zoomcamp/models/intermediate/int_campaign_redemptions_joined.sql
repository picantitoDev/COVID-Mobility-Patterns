-- Consolida eventos de redención con las fechas y tipos de campaña
with redemptions as (
    select * from {{ ref('stg_coupon_redempt') }}
),

campaigns as (
    select * from {{ ref('stg_campaign_desc') }}
),

joined as (
    select
        r.household_id,
        r.redemption_day,
        r.coupon_upc,
        r.campaign_id,
        
        c.campaign_type,
        c.start_day,
        c.end_day,
        
        -- Lógica de negocio: Validar si el cupón se redimió dentro del periodo oficial
        case
            when r.redemption_day between c.start_day and c.end_day then true
            else false
        end as is_redeemed_in_window

    from redemptions r
    left join campaigns c 
        on r.campaign_id = c.campaign_id
)

select * from joined