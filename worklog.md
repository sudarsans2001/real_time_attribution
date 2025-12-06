# Work Log

## Entry 1 – <06/12/2025 12:20AM>
Created project folder and Git repo. Planning Real time attribution for streaming.

## Entry 2 – <12:33AM>
Set up GCP project and created BigQuery dataset `attribution_pipeline`.
Confirmed GA4 dataset is avilable bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*.

## Entry 3 – <01:01AM>
Created architecture sketch showing GA4 → dbt → BigQuery → Looker Studio and streaming flow.

## Entry 4 – <01:31AM>
Installed dbt-bigquery and initialized dbt project `attribution_project` using dataset `attribution_pipeline`.

## Entry 5 – <02:26AM>
Configured dbt BigQuery profile and verified connection using `dbt debug`.

## Entry 6 – <01:18PM>
Implemented `stg_ga4_events` model reading from GA4 public dataset.
Added basic tests (not_null) for key columns and ran dbt run + test

## Entry 7 – <01:45PM>
Implemented int_sessions model using 30-minute inactivity-based sessionization.
Added test file for session_number(not_null). Ran dbt run + test successfully.

## Entry 8– <02:32PM>
Added mart_last_click using descending timestamp rank. Verified outputs.

## Entry 9 – <07-12-2025 12:18PM>
Created streaming_events table and wrote streaming_demo.py to generate 10 events.
