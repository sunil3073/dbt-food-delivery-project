
{% snapshot snap_customers %}

{{
  config(
    target_schema='SNAPSHOT',
    unique_key='customer_id',
    strategy='check',
    check_cols=['hash_diff'],
    invalidate_hard_deletes=true
  )
}}

select
  customer_id,
  customer_name,
  city,
  signup_date,
  sha2(
    concat(
      coalesce(customer_name, ''),
      coalesce(city, ''),
      coalesce(signup_date::string, '')
    ), 256
  ) as hash_diff
from {{ ref('stg_customers') }}

{% endsnapshot %}
