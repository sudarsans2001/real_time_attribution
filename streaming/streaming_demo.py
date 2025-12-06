from google.cloud import bigquery
from datetime import datetime
import uuid
import random

client = bigquery.Client()

table_id = "dbtprojects1.attribution_pipeline.streaming_events"

sources = [
    ("google", "cpc", "search_summer"),
    ("facebook", "paid_social", "fb_conversion"),
    ("direct", "(none)", "(none)"),
    ("email", "newsletter", "promo_jan")
]

pages = ["/home", "/product", "/cart", "/checkout"]

def generate_event():
    source, medium, campaign = random.choice(sources)
    return {
        "event_id": str(uuid.uuid4()),
        "user_pseudo_id": str(random.randint(1000, 9999)),
        "event_ts": datetime.utcnow().isoformat(),
        "page": random.choice(pages),
        "source": source,
        "medium": medium,
        "campaign": campaign
    }

events = [generate_event() for _ in range(10)]

job = client.load_table_from_json(events, table_id) # tried using batch insert using BigQuery jobs
job.result() 

print(f"Loaded {len(events)} events into {table_id}")
