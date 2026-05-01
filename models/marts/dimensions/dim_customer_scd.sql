{{
    config(
        materialized='table',
        tags=['marts', 'snapshot']
    )
}}

with raw_snapshot as (
    select * from {{ ref('snap_customers')}}
),

version as (
    select   
            customer_id,
            customer_name,
            city,
            signup_date,
            hash_diff,
            dbt_valid_from as date_start,
            dbt_valid_to as date_to 
    from raw_snapshot        
),

with_flag as (
    select *,
         case
            when date_to is null then 'active'
            else 'inactive'
            end as status_flag
    from version
),

final as (
    select 
        hash(CONCAT(customer_id, '|', date_start)) AS scd_id,
        customer_id,
        customer_name,
        city,
        signup_date,
        hash_diff,
        date_start,
        case
            when date_to is null then cast('9999-12-31' as timestamp_ntz)
            else date_to
            end as date_to,
        status_flag,
        current_timestamp() as record_inserted_at
    from with_flag    
)

select * from final