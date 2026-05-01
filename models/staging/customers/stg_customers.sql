{{ 
    config(
        materialized= 'view',
        tags=['staging' , 'customers']
    )
}}

with source_data as(
    select * from {{source('raw', 'CUSTOMERS')}}
),

renamed as(
select CUSTOMER_ID, 
       CUSTOMER_NAME, 
       CITY, 
       SIGNUP_DATE
from source_data
),

cleaned as (
    select CUSTOMER_ID,
           trim(CUSTOMER_NAME) as CUSTOMER_NAME,
           trim(CITY) as CITY,
           SIGNUP_DATE::date as SIGNUP_DATE
    from renamed
)
select * from cleaned