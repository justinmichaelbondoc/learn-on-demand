{{ config(
    materialized='table',
    tags=['repro_138327'],
    pre_hook="call system$wait(8)"
) }}

{%- for i in range(1200) %}
{%- do log("repro_138327 filler log line " ~ i, info=True) %}
{%- endfor %}

-- Intentional runtime failure (divide by zero) after an 8s delay, now
-- positioned behind a 10-step upstream chain (chain/step_01..10) rather
-- than being the DAG's own root, to test whether failure depth/position
-- in the DAG affects the Failure/Unknown status display bug (ticket #138327).
select 1/0 as will_never_resolve from {{ ref('step_10') }}
