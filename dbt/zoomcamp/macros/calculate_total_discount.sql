{% macro calculate_total_discount(retailer_match, manufacturer_disc, loyalty_disc) %}
    -- En Dunnhumby los descuentos suelen venir en negativo. Usamos ABS para tener el monto real ahorrado.
    abs(coalesce({{ retailer_match }}, 0)) + 
    abs(coalesce({{ manufacturer_disc }}, 0)) + 
    abs(coalesce({{ loyalty_disc }}, 0))
{% endmacro %}