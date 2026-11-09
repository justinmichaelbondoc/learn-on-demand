{% macro slow(seconds=120) %}
    {% do run_query("select pg_sleep(" ~ seconds ~ ")") %}
{% endmacro %}