{% test is_greater_or_equal_to_zero(model, column_name) %}

with

validation as (

    select
        {{ column_name }} as integer_column
    
    from {{ model }}

),

validation_errors as (

    select
        integer_column
    
    from validation

    where
        integer_column < 0

)

select * 
from validation_errors


{% endtest %}