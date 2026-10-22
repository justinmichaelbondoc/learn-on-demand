select
    employee_id,
    email,
    customer_id

from {{ ref('employees') }}
