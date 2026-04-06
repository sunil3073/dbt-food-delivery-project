{{ config(
    materialized='table',
    tags=['mart', 'kpi']
) }}

with orders as (

    select *
    from {{ ref('fct_orders') }}

),

aggregated as (

    select
        cast(order_time as date) as order_date,
        count(distinct order_id) as total_orders,
        count(distinct customer_id) as total_customers,
        count(distinct restaurant_id) as total_restaurants,
        sum(total_amount) as gross_revenue,
        avg(total_amount) as avg_order_value,
        sum(total_quantity) as total_items_sold
    from orders
    group by cast(order_time as date)

)

select *
from aggregated
order by order_date