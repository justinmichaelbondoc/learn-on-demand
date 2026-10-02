{{ config(materialized='view', tags=['repro_138327']) }}
select * from {{ ref('stg_repro_root') }}
