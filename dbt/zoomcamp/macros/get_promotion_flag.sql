{% macro get_promotion_flag(column_name) %}
    -- Convierte los códigos crípticos de Dunnhumby ('0', 'A', '1') en booleanos útiles para analítica
    case
        when trim(cast({{ column_name }} as string)) in ('0', '', ' ') or {{ column_name }} is null then false
        else true
    end
{% endmacro %}