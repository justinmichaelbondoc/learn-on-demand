{# Repro helper for ticket 139296 (not for production use).
   Lists SHOW statements issued by the current Snowflake user in the last N minutes,
   one row per statement with a UTC timestamp, so invocations can be told apart. #}
{% macro repro_139296_show_counts(minutes=6) %}
  {% set q %}
    select
      convert_timezone('UTC', start_time)::varchar as ts,
      lower(regexp_substr(query_text, $$show [a-z ]+ in [^\s;/]+$$, 1, 1, 'i')) as show_stmt
    from table(information_schema.query_history_by_user(
      user_name => current_user(),
      end_time_range_start => dateadd('minute', -{{ minutes }}, current_timestamp()),
      result_limit => 10000))
    where query_type = 'SHOW'
    order by start_time
  {% endset %}
  {% set results = run_query(q) %}
  {% for row in results.rows %}
    {{ log('SHOWQ | ' ~ row[0] ~ ' | ' ~ row[1], info=True) }}
  {% endfor %}
  {{ log('SHOWQ_ROWS | ' ~ (results.rows | length), info=True) }}
{% endmacro %}
