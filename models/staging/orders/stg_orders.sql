{{ config(
    materialized='view',
    tags=['staging', 'orders']
) }}

with source_data as (

    select *
    from {{ source('raw', 'orders') }}

),

cleaned as (

    select
        trim(order_id) as order_id,
        trim(customer_id) as customer_id,
        trim(restaurant_id) as restaurant_id,
        cast(order_time as timestamp) as order_time,
        cast(delivery_time as timestamp) as delivery_time,
        lower(trim(status)) as status,
        cast(total_amount as number(10,2)) as total_amount
    from source_data

)

select *
from cleaned