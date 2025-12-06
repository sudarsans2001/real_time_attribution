{{ config(
    materialized='table'
) }}

with ranked as (
    select
        user_pseudo_id,
        session_number,
        source,
        medium,
        campaign,
        event_ts,
        row_number() over(
            partition by user_pseudo_id, session_number
            order by event_ts
        ) as rn
    from {{ ref('int_sessions') }}
)

select
    user_pseudo_id,
    session_number,
    source,
    medium,
    campaign,
    event_ts as first_event_ts
from ranked
where rn = 1
