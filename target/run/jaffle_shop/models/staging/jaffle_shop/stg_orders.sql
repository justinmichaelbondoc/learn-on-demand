
  create or replace   view ANALYTICS.dbt_jbondoc.stg_orders
  
  
  
  
  as (
    with

source as (

    select * from raw.jaffle_shop.orders
),

select
    id as order_id,
    user_id as customer_id,
    order_date,
    datediff('day', order_date, convert_timezone('UTC', current_timestamp()) } as days_since_ordered),
    status like '%pending%' as is_status_pending,
    case
        when status like '%pending%' then 'placed'
        when status like '%return%' then 'returned'
        else status
    end as status
from source

)

select * from staged

  );

