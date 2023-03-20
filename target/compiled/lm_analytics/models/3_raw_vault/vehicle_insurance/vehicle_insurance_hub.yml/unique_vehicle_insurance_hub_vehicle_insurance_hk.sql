
    
    

select
    vehicle_insurance_hk as unique_field,
    count(*) as n_records

from DBT_TEST.dbt_test_dbt_test.vehicle_insurance_hub
where vehicle_insurance_hk is not null
group by vehicle_insurance_hk
having count(*) > 1


