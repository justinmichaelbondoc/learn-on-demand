{% macro slow(seconds=300) %}
    {% do run_query("call system$wait(" ~ seconds ~ ")") %}
{% endmacro %}
