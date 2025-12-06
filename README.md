## Source Dataset

We use the GA4 public sample dataset:

- Project: bigquery-public-data
- Dataset: ga4_obfuscated_sample_ecommerce
- Table pattern: events_*

## Idempotency

We enforce idempotency using event_id as a UUID per event. If the script runs twice, we can dedupe later using this below query

SELECT * EXCEPT(row_num)
FROM (
  SELECT *, 
         ROW_NUMBER() OVER(PARTITION BY event_id ORDER BY event_ts DESC) AS row_num
  FROM attribution_pipeline.streaming_events
)
WHERE row_num = 1;

## Dedupe

event_id is unique it serves as a  dedupe key here. BigQuery streaming inserts tolerate duplicates, but we can remove with ROW_NUMBER

## Latency

BigQuery streaming API takes 1–3 seconds typical

Perfect for “near realtime” dashboard queries