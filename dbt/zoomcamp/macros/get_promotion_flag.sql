/*
  Convert Dunnhumby promotion indicator codes into a boolean flag.
  - Returns FALSE for null, blank, whitespace, or '0'
  - Returns TRUE for all other values

  This standardizes inconsistent source promotion codes
  for downstream analytics.
*/

{% macro get_promotion_flag(column_name) %}

case
    when trim(cast({{ column_name }} as string)) in ('0', '', ' ')
         or {{ column_name }} is null
    then false

    else true
end

{% endmacro %}