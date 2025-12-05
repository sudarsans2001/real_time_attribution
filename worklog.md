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
