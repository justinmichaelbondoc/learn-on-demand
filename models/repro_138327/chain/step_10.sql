{{ config(materialized='table', tags=['repro_138327'], pre_hook="call system$wait(1)") }}

{%- for i in range(400) %}
{%- do log("repro_138327 pre-failure chain log line " ~ i, info=True) %}
{%- endfor %}

select * from {{ ref('step_09') }}
