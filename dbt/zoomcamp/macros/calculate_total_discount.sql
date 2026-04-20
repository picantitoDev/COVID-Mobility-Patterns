{% macro calculate_total_discount(retailer_match, manufacturer_disc, loyalty_disc) %}

-- Dunnhumby discount values are typically stored as negatives.
-- Use ABS() to calculate the total realized discount amount.

abs(coalesce({{ retailer_match }}, 0))
+ abs(coalesce({{ manufacturer_disc }}, 0))
+ abs(coalesce({{ loyalty_disc }}, 0))

{% endmacro %}