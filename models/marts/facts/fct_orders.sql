{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

with order_metrics as (

    select         order_id,
        customer_id,
        restaurant_id,
        order_time,
        delivery_time,
        status,
        {{ cents_to_dollars('total_amount')}} as total_amount,
        total_items,
        total_quantity,
        calculated_order_amount
    from {{ ref('int_order_metrics') }}

)

select *
from order_metrics

{% if is_incremental() %}
where order_time > (select max(order_time) from {{ this }})
{% endif %}