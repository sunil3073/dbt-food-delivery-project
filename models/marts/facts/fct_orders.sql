{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

with order_metrics as (

    select *
    from {{ ref('int_order_metrics') }}

)

select *
from order_metrics

{% if is_incremental() %}

where order_time > (select max(order_time) from {{ this }})

{% endif %}