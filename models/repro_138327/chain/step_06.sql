{{ config(materialized='table', tags=['repro_138327'], pre_hook="call system$wait(1)") }}
select * from {{ ref('step_05') }}
