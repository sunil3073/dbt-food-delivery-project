{% macro get_recent_date(days) %}
 
    DATEADD(DAY,-{{days}},CURRENT_DATE)

{% endmacro %}