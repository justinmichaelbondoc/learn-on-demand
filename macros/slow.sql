{% macro slow(seconds=180) %}
    {% do run_query("call system$wait(" ~ seconds ~ ")") %}
{% endmacro %}
