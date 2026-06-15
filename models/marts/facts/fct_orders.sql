{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

with order_metrics as (

    select         
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} as order_sk,
        order_id,
        customer_id,
        restaurant_id,
        order_time,
        delivery_time,
        status,
        {{ cents_to_dollars('total_amount')}} as total_amount,
        total_items,
        total_quantity,
        calculated_order_amount,
        {{ metadata_audit }}
    from {{ ref('int_order_metrics') }}

)

select *
from order_metrics

{% if is_incremental() %}
where order_time > (select max(order_time) from {{ this }})
{% endif %}