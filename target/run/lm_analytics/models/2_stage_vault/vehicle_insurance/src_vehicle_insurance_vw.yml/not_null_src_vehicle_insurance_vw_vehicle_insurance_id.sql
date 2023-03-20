select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
        select *
        from DBT_TEST.dbt_test_dbt_test__audit.not_null_src_vehicle_insurance_vw_vehicle_insurance_id
    
      
    ) dbt_internal_test