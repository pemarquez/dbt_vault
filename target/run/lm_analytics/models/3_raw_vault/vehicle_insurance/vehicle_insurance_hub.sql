-- back compat for old kwarg name
  
  begin;
    

        insert into DBT_TEST.dbt_test_dbt_test.vehicle_insurance_hub ("VEHICLE_INSURANCE_HK", "VEHICLE_INSURANCE_ID", "ETL_LOAD_DATETIME", "SOURCE")
        (
            select "VEHICLE_INSURANCE_HK", "VEHICLE_INSURANCE_ID", "ETL_LOAD_DATETIME", "SOURCE"
            from DBT_TEST.dbt_test_dbt_test.vehicle_insurance_hub__dbt_tmp
        );
    commit;