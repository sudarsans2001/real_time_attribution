{{ config(
    materialized='table'
) }}

with base as (
    select
        *,
        timestamp_micros(event_timestamp) as event_ts
    from {{ ref('stg_ga4_events') }}
),

session_boundaries as (
    select
        *,
        case
            when lag(event_ts) over(
                    partition by user_pseudo_id
                    order by event_ts
                ) is null then 1

            when lag(event_ts) over(
                    partition by user_pseudo_id
                    order by event_ts
                ) < event_ts - interval 30 minute then 1

            else 0
        end as is_new_session
    from base
),

session_ids as (
    select
        *,
        sum(is_new_session) over(
            partition by user_pseudo_id
            order by event_ts
            rows between unbounded preceding and current row
        ) as session_number
    from session_boundaries
)

select 
    user_pseudo_id,
    session_number,
    source,
    medium,
    campaign,
    event_ts,
    event_date,
    page_location,
    page_title
from session_ids
