{{ 
    config(
        materialized = 'ephemeral'
    )
}}

WITH listings AS (
    SELECT
        LISTING_ID,
        PROPERTY_TYPE,
        ROOM_TYPE,
        CITY,
        LISTING_CREATED_AT

    FROM
        {{ ref('obt') }}
    )
SELECT * from listings