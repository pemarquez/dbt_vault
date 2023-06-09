/* set yaml_metadata and endset are used for assigning variable ( key value pairs) *//* fromyml() built-in jinja function  assigns values to variables */




/*
dbtvault will generate a stage using parameters provided in the next steps.
The recommended materialization for a stage is view, as the stage layer contains minimal transformations on the raw staging layer which need to remain in sync. 
The "source model" for a stage is coming from src_<tablename>_vw
the "derived_columns" derives source, effective_from & end_date
the "hashed_columns" represent columns to be hashed on business keys 
the "ranked_columns" and "null_columns" are not used 
Refer to following link for additional info https://dbtvault.readthedocs.io/en/latest/tutorial/tut_staging/
*/


-- Generated by dbtvault.

    

WITH source_data AS (

    SELECT

    "VEHICLE_INSURANCE_ID",
    "GENDER",
    "AGE",
    "DRIVING_LICENSE",
    "REGION_CODE",
    "PREVIOUSLY_INSURED",
    "VEHICLE_AGE",
    "VEHICLE_DAMAGE",
    "ANNUAL_PREMIUM",
    "POLICY_SALES_CHANNEL",
    "VINTAGE",
    "REC_CREATE_DATE",
    "REC_UPDATE_DATE",
    "REC_CREATE_BY",
    "REC_UPDATE_BY"

    FROM DBT_TEST.dbt_test.src_vehicle_insurance_vw
),

derived_columns AS (

    SELECT

    "VEHICLE_INSURANCE_ID",
    "GENDER",
    "AGE",
    "DRIVING_LICENSE",
    "REGION_CODE",
    "PREVIOUSLY_INSURED",
    "VEHICLE_AGE",
    "VEHICLE_DAMAGE",
    "ANNUAL_PREMIUM",
    "POLICY_SALES_CHANNEL",
    "VINTAGE",
    "REC_CREATE_DATE",
    "REC_UPDATE_DATE",
    "REC_CREATE_BY",
    "REC_UPDATE_BY",
    'eirssys' AS "SOURCE",
    current_timestamp AS "ETL_LOAD_DATETIME",
    current_date AS "EFFECTIVE_FROM",
    to_date('9999-12-31','YYYY-MM-DD') AS "END_DATE"

    FROM source_data
),

hashed_columns AS (

    SELECT

    "VEHICLE_INSURANCE_ID",
    "GENDER",
    "AGE",
    "DRIVING_LICENSE",
    "REGION_CODE",
    "PREVIOUSLY_INSURED",
    "VEHICLE_AGE",
    "VEHICLE_DAMAGE",
    "ANNUAL_PREMIUM",
    "POLICY_SALES_CHANNEL",
    "VINTAGE",
    "REC_CREATE_DATE",
    "REC_UPDATE_DATE",
    "REC_CREATE_BY",
    "REC_UPDATE_BY",
    "SOURCE",
    "ETL_LOAD_DATETIME",
    "EFFECTIVE_FROM",
    "END_DATE",

    CAST(MD5_BINARY(NULLIF(CONCAT_WS('||',
        IFNULL(NULLIF(UPPER(TRIM(CAST("VEHICLE_INSURANCE_ID" AS VARCHAR))), ''), '^^')
    ), '^^')) AS BINARY(16)) AS "VEHICLE_INSURANCE_HK",
    CAST(MD5_BINARY(NULLIF(CONCAT_WS('||',
        IFNULL(NULLIF(UPPER(TRIM(CAST("VEHICLE_INSURANCE_ID" AS VARCHAR))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST("GENDER" AS VARCHAR))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST("AGE" AS VARCHAR))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST("DRIVING_LICENSE" AS VARCHAR))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST("REGION_CODE" AS VARCHAR))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST("PREVIOUSLY_INSURED" AS VARCHAR))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST("VEHICLE_AGE" AS VARCHAR))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST("VEHICLE_DAMAGE" AS VARCHAR))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST("ANNUAL_PREMIUM" AS VARCHAR))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST("POLICY_SALES_CHANNEL" AS VARCHAR))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST("VINTAGE" AS VARCHAR))), ''), '^^')
    ), '^^||^^||^^||^^||^^||^^||^^||^^||^^||^^||^^')) AS BINARY(16)) AS "HASHDIFF"

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    "VEHICLE_INSURANCE_ID",
    "GENDER",
    "AGE",
    "DRIVING_LICENSE",
    "REGION_CODE",
    "PREVIOUSLY_INSURED",
    "VEHICLE_AGE",
    "VEHICLE_DAMAGE",
    "ANNUAL_PREMIUM",
    "POLICY_SALES_CHANNEL",
    "VINTAGE",
    "REC_CREATE_DATE",
    "REC_UPDATE_DATE",
    "REC_CREATE_BY",
    "REC_UPDATE_BY",
    "SOURCE",
    "ETL_LOAD_DATETIME",
    "EFFECTIVE_FROM",
    "END_DATE",
    "VEHICLE_INSURANCE_HK",
    "HASHDIFF"

    FROM hashed_columns
)

SELECT * FROM columns_to_select