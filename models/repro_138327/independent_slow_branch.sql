{{ config(
    materialized='table',
    tags=['repro_138327'],
    pre_hook="call system$wait(90)"
) }}

-- Independent of stg_repro_root. Keeps the overall job status "Running" for
-- ~90s after the root model fails, giving a window to watch the Run page
-- while the Failed/Skipped nodes are already resolved internally but the
-- run hasn't finished (ticket #138327).
select 1 as keep_alive
