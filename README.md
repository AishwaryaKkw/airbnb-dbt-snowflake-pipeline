**Airbnb dbt Snowflake Pipeline**

A multi-layer data pipeline built using dbt and Snowflake on Airbnb data. The project follows the Medallion Architecture (Bronze → Silver → Gold) to transform raw data into analytics-ready models.


**Tech Stack**

AWS S3 — raw data storage
Snowflake — cloud data warehouse + COPY INTO for S3 ingestion
dbt Core 1.11.10 — data transformation
Python 3.12

**Architecture**

AWS S3 Bucket
    (raw CSV files)
        │
        │  COPY INTO (Snowflake stage)
        ▼
AIRBNB.STAGING (Snowflake Source)
        │
        ▼
  ┌─────────────┐
  │   Bronze    │  Raw tables — direct copy from source
  │  (tables)   │  bronze_listings, bronze_bookings, bronze_hosts
  └─────────────┘
        │
        ▼
  ┌─────────────┐
  │   Silver    │  Cleaned + transformed — incremental models
  │(incremental)│  silver_listings, silver_bookings, silver_hosts
  └─────────────┘
        │
        ▼
  ┌─────────────┐
  │    Gold     │  Analytics-ready — fact table, OBT, ephemeral models
  │  (tables)   │  fact, obt, ephemeral (bookings, hosts, listings)
  └─────────────┘
        │
        ▼
  ┌─────────────┐
  │  Snapshots  │  SCD Type 2 — tracks historical changes
  │   (gold)    │  dim_listings, dim_hosts, dim_bookings
  └─────────────┘

**Project Structure**

aws_dbt_snowflake_project/
├── models/
│   ├── bronze/          # Raw layer
│   ├── silver/          # Cleaned layer (incremental)
│   ├── gold/            # Analytics layer
│   │   └── ephemeral/   # Ephemeral intermediate models
│   └── sources/         # Source definitions (sources.yml)
├── snapshots/           # SCD Type 2 snapshots
├── macros/              # Custom Jinja macros
├── tests/               # Custom data tests
├── seeds/
├── analyses/
└── dbt_project.yml  


**Models**
Bronze- 
bronze_listings -Raw listings data from Airbnb staging
bronze_bookings -Raw bookings data from Airbnb staging
bronze_hosts -Raw hosts data from Airbnb staging

Silver
silver_listings - IncrementalCleaned listings with price tags
silver_bookings - IncrementalCleaned bookings data
silver_hosts - IncrementalCleaned hosts data

Gold
fact Table - Core fact table joining all entities
obt Table - One Big Table for analytics
bookings Ephemeral - Intermediate bookings model
listings Ephemeral - Intermediate listings model 
hosts Ephemeral - Intermediate hosts model