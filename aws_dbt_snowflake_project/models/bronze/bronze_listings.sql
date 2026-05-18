{{ config(materialized='table') }}  -- This line configures the model to be materialized as a table in the database. You can change this to 'view' if you prefer to create a view instead.

SELECT * FROM {{ source('staging', 'listings') }}

{% if is_incremental() %}
    WHERE CREATE_AT > (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') FROM {{ this }})
{% endif %}