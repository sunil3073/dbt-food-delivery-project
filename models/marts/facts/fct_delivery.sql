{{ config(
    materialized='table',
    tags=['mart', 'fact', 'delivery']
) }}

with delivery_metrics as (

    select *
    from {{ ref('int_delivery_metrics') }}

)

select
    order_id,
    customer_id,
    restaurant_id,
    order_time,
    delivery_time,
    status,
    total_amount,
    delivery_partner_id,
    delivery_time_minutes,
    delivery_performance
from delivery_metrics