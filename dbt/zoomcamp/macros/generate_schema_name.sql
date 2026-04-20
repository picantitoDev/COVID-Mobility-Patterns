/*
  Override dbt's default schema generation behavior:
  - Uses target.schema when no custom schema is provided.
  - Uses the custom schema when explicitly defined.

  This prevents dbt from automatically concatenating schemas
  (for example: analytics_staging) and preserves intended dataset names.
*/

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    
    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}

{%- endmacro %}