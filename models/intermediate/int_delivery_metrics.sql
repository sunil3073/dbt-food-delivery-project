{{ config(
    materialized='view',
    tags=['intermediate', 'delivery']
) }}

with orders as (

    select *
    from {{ ref('stg_orders') }}

),

delivery as (

    select *
    from {{ ref('stg_delivery') }}

),

joined as (

    select
        o.order_id,
        o.customer_id,
        o.restaurant_id,
        o.order_time,
        o.delivery_time,
        o.status,
        o.total_amount,
        d.delivery_partner_id,
        d.delivery_time_minutes,
        case
            when d.delivery_time_minutes <= 30 then 'on_time'
            else 'late'
        end as delivery_performance
    from orders o
    left join delivery d
        on o.order_id = d.order_id

)

select *
from joined