
    
    

select
    VEHICLE_INSURANCE_ID || '-' || ANNUAL_PREMIUM as unique_field,
    count(*) as n_records

from DBT_TEST.dbt_test_dbt_test.vehicle_insurance_stage_vw
where VEHICLE_INSURANCE_ID || '-' || ANNUAL_PREMIUM is not null
group by VEHICLE_INSURANCE_ID || '-' || ANNUAL_PREMIUM
having count(*) > 1


