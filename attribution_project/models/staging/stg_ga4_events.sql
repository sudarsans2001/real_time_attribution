select
  event_timestamp,
  event_date,
  user_pseudo_id,

  traffic_source.source as source,
  traffic_source.medium as medium,
  traffic_source.name as campaign,

  (select value.string_value
   from unnest(event_params)
   where key = 'page_location') as page_location,

  (select value.string_value
   from unnest(event_params)
   where key = 'page_title') as page_title

from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`