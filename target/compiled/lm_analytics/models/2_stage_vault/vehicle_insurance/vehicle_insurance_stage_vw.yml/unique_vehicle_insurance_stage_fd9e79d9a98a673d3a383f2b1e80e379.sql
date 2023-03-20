
    
    

select
    INCIDENT_ID || '-' || VEHICLE_INSURANCE_NUMBER as unique_field,
    count(*) as n_records

from DBT_TEST.dbt_test_dbt_test.vehicle_insurance_stage_vw
where INCIDENT_ID || '-' || VEHICLE_INSURANCE_NUMBER is not null
group by INCIDENT_ID || '-' || VEHICLE_INSURANCE_NUMBER
having count(*) > 1


