{{ config(
    materialized='view',
    tags=['intermediate', 'metrics']
) }}

with enriched_items as (

    select *
    from {{ ref('int_order_items_enriched') }}

),

aggregated as (

    select
        order_id,
        customer_id,
        restaurant_id,
        min(order_time) as order_time,
        min(delivery_time) as delivery_time,
        min(status) as status,
        min(total_amount) as total_amount,
        count(distinct order_item_id) as total_items,
        sum(quantity) as total_quantity,
        sum(item_total) as calculated_order_amount
    from enriched_items
    group by
        order_id,
        customer_id,
        restaurant_id

)

select *
from aggregated