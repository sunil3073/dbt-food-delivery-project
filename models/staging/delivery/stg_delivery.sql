{{ config(
    materialized='view',
    tags=['staging', 'delivery']
) }}

with source_data as (

    select *
    from {{ source('raw', 'delivery') }}

),

cleaned as (

    select
       ORDER_ID, 
       DELIVERY_PARTNER_ID, 
       DELIVERY_TIME_MINUTES
    from source_data

)

select *
from cleaned