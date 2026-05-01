{{
    config(
        materalized='table',
        schema= 'marts',
        tags=['dimensions', 'marts', 'customers']
    )
}}

with customers  as (
    select * from {{ ref('stg_customers') }}
)

select customer_id,
        customer_name,
        city,
        signup_date
from customers         