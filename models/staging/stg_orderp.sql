{{
    config(materialized='view',
    unique_key='order_id')
}}

select order_id as order_id,
        customer_id as customer_id,
         order_time as order_time,
        status
from {{ ref('stg_orders') }} 