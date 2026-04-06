{{
    config(
        materalized= 'table',
        tags= ['marts', 'dimension', 'restaurant']
    )
}}



with restaurants as (

    select *
    from {{ ref('stg_restaurants') }}

)

select
    restaurant_id,
    restaurant_name,
    city,
    cuisine
from restaurants