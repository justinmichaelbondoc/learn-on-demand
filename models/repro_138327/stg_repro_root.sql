{{ config(
    materialized='table',
    tags=['repro_138327'],
    pre_hook="call system$wait(8)"
) }}

-- Intentional runtime failure (divide by zero) after an 8s delay, to simulate
-- an early-DAG root-cause failure (ticket #138327).
select 1/0 as will_never_resolve
