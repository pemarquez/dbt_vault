select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from DBT_TEST.dbt_test_dbt_test__audit.unique_vehicle_insurance_stage_2f68a06641be5f6e06bbd9d35bc5a6b1
    
      
    ) dbt_internal_test