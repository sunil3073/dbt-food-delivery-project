{% snapshot city_changes %}

{{
    config(
           target_schema='SNAPSHOTS',
           unique_key ='customer_id',
           strategy ='check',
           check_cols= ['city']
    )
}}

select * from  {{ ref('stg_customers')}}



{% endsnapshot %}