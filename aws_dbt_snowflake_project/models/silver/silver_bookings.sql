{{ config(
    materialized='incremental',
    unique_key='BOOKING_ID' 
    )
}}  -- This line configures the model to be materialized as an incremental model in the database. The 'keys' parameter specifies the column(s) that will be used to identify unique records for incremental updates for UPSERT operations. 

SELECT 
    BOOKING_ID,
    LISTING_ID,
    BOOKING_DATE,
    {{ multiply('NIGHTS_BOOKED', 'BOOKING_AMOUNT', 2)}} AS TOTAL_AMOUNT,
    CLEANING_FEE,
    SERVICE_FEE,
    BOOKING_STATUS,
    CREATED_AT,
FROM {{ ref('bronze_bookings')
}}
    
