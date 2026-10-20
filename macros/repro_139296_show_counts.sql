{# Repro helper for ticket 139296 (not for production use).
   Lists SHOW statements issued by the current Snowflake user in the last N minutes,
   grouped by statement, so we can see what the relation cache populated at run start. #}
{% macro repro_139296_show_counts(minutes=2) %}
  {% set q %}
    select
      lower(regexp_substr(query_text, 'show [a-z ]+ in [^ ;]+', 1, 1, 'i')) as show_stmt,
      count(*) as n
    from table(information_schema.query_history_by_user(
      user_name => current_user(),
      end_time_range_start => dateadd('minute', -{{ minutes }}, current_timestamp()),
      result_limit => 10000))
    where query_type = 'SHOW'
    group by 1
    order by 1
  {% endset %}
  {% set results = run_query(q) %}
  {{ log('SHOWQ_TOTAL | ' ~ (results.rows | map(attribute=1) | sum), info=True) }}
  {% for row in results.rows %}
    {{ log('SHOWQ | ' ~ row[0] ~ ' | ' ~ row[1], info=True) }}
  {% endfor %}
{% endmacro %}
