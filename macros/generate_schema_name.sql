-- This macro overrides dbt's default schema naming behavior.
-- It uses the model's custom schema when one is provided.
-- If no custom schema is configured, it falls back to target.schema.
-- This keeps schema names predictable across environments and makes
-- the project's schema naming strategy explicit.

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}

        {{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}