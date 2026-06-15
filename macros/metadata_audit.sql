{% metadata_audit() %}
    current_timestamp as dbt_loaded_at,
    '{{ this.name }}' as dbt_model_name,
    '{{ env_var("DBT_ENV", "dev") }}' as dbt_environment,
    '{{ run_strated_at }}' as dbt_run_stratrd_at
{% endmacro %}