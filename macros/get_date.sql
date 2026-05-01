{% macro get_recent_date(days) %}
 
    DATEADD(DAY,-{{DAYS}},CURRENT_DATE)

{% endmacro %}