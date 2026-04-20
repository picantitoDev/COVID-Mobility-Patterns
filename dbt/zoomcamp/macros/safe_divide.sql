/*
    Macro: safe_divide
    Purpose: Prevent division by zero.
*/

{% macro safe_divide(numerator, denominator) %}
    case 
        when {{ denominator }} = 0 or {{ denominator }} is null then 0
        else {{ numerator }} / {{ denominator }}
    end
{% endmacro %}