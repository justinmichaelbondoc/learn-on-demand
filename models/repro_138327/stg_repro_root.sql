{{ config(
    materialized='table',
    tags=['repro_138327'],
    pre_hook="call system$wait(8)"
) }}

{%- for i in range(1200) %}
{%- do log("repro_138327 filler log line " ~ i, info=True) %}
{%- endfor %}

-- Intentional runtime failure (divide by zero) after an 8s delay, with
-- ~1200 injected log lines above to exceed the in-progress log
-- truncation cap (1000 lines / 0.5MB) ticket #138327 also reported.
select 1/0 as will_never_resolve
