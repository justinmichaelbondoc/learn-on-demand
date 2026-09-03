
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    amount
from ANALYTICS.dbt_jbondoc.fct_orders
where amount <= 5


  
  
      
    ) dbt_internal_test