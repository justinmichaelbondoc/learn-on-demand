
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  select
    customer_id, 
    avg(amount) as average_amount
from ANALYTICS.dbt_jbondoc.fct_orders
group by 1
having count(customer_id) > 1 and average_amount < 1
  
  
      
    ) dbt_internal_test