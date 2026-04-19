{% macro safe_divide(numerator, denominator) %}
    -- Previene errores de división por cero (muy común al calcular tickets promedios)
    case 
        when {{ denominator }} = 0 or {{ denominator }} is null then 0
        else {{ numerator }} / {{ denominator }}
    end
{% endmacro %}