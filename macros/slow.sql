{% macro slow(seconds=120) %}
    {% do run_query("call system$wait(" ~ seconds ~ ")") %}
{% endmacro %}
