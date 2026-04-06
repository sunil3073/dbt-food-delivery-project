{{ config(
    materialized='view',
    tags=['intermediate', 'orders']
) }}

with orders as (

    select *
    from {{ ref('stg_orders') }}

),

order_items as (

    select *
    from {{ ref('stg_order_items') }}

),

joined as (

    select
        oi.order_item_id,
        oi.order_id,
        o.customer_id,
        o.restaurant_id,
        o.order_time,
        o.delivery_time,
        o.status,
        o.total_amount,
        oi.item_name,
        oi.quantity,
        oi.unit_price,
        oi.quantity * oi.unit_price as item_total
    from order_items oi
    left join orders o
        on oi.order_id = o.order_id

)

select *
from joined