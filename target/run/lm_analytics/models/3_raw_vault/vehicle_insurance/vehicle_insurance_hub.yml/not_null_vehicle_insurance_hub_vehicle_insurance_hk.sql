select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from DBT_TEST.dbt_test_dbt_test__audit.not_null_vehicle_insurance_hub_vehicle_insurance_hk
    
      
    ) dbt_internal_test