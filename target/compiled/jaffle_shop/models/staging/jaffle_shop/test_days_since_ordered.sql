-- Build actual result given inputs
WITH
            	"raw_jaffle_shop_orders" as (SELECT CAST(NULL AS NUMBER) AS ID, CAST(NULL AS NUMBER) AS USER_ID, CAST('2024-01-01' AS DATE) AS ORDER_DATE, CAST(NULL AS VARCHAR) AS STATUS, CAST(NULL AS TIMESTAMP_NTZ(9)) AS _ETL_LOADED_AT),
  	"ANALYTICS_dbt_jbondoc_stg_orders_expect" as (SELECT CAST(NULL AS NUMBER) AS ORDER_ID, CAST(NULL AS NUMBER) AS CUSTOMER_ID, CAST('2024-01-01' AS DATE) AS ORDER_DATE, CAST(14 AS NUMBER) AS DAYS_SINCE_ORDERED, CAST(NULL AS BOOLEAN) AS IS_STATUS_PENDING, CAST(NULL AS VARCHAR) AS STATUS),
  	"ANALYTICS_dbt_jbondoc_stg_orders_actual" as (with

source as (

    select * from "raw_jaffle_shop_orders"
),

staged as (

    select
    id as order_id,
    user_id as customer_id,
    order_date,
    datediff('day', order_date, date('2024-01-15') ) as days_since_ordered,
    status like '%pending%' as is_status_pending,
    case
        when status like '%shipped%' then 'shipped'
        when status like '%return%' then 'returned'
        when status like '%pending%' then 'placed'
        else status
    end as status
from source

)

select * from staged

)
        SELECT * FROM (
        (SELECT ORDER_DATE, DAYS_SINCE_ORDERED, 'actual' AS actual_or_expected FROM "ANALYTICS_dbt_jbondoc_stg_orders_actual")
        UNION ALL
        (SELECT ORDER_DATE, DAYS_SINCE_ORDERED, 'expected' AS actual_or_expected FROM "ANALYTICS_dbt_jbondoc_stg_orders_expect")
        ) unit_test_diff
        ORDER BY ORDER_DATE, DAYS_SINCE_ORDERED