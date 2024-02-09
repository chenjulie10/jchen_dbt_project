{% macro secs_to_mins(column_name, decimal_places=1) %}

    round({{ column_name }} / 60, {{ decimal_places }})

{% endmacro %}
