{% test greater_than_five(model, column_name) %}

select
    {{ column_name }}
from {{ ref('fct_orders')}}
where {{ column_name }} <= 5

{% endtest %}