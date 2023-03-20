
    
    

select
    incident_id || '-' || vehicle_insurance_number as unique_field,
    count(*) as n_records

from DBT_TEST.dbt_test_dbt_test.vehicle_insurance_stage_vw
where incident_id || '-' || vehicle_insurance_number is not null
group by incident_id || '-' || vehicle_insurance_number
having count(*) > 1


