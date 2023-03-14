

{% docs vehicle_insurance_id %}

Column **vehicle_insurance_id** obtained from source  unique id for each incident. It is the primary key
for the dataset.

{% enddocs %}

{% docs rec_create_date %}

Column **rec_create_date** represents the record created date. It is an audit column to help track
records created in the database table. This column will never be updated.

{% enddocs %}

{% docs rec_update_date %}

Column **rec_update_date** represents the record updated date. It is an audit column to help track
records updated in the database table. This column is updated with a timestamp when one or more columns
for this specific row is updated.

*NOTE:* when the row is initially created, this column will have the same timestamp as the **rec_create_date**

{% enddocs %}

{% docs rec_create_by %}

Column **rec_create_by** represents the process that created the record. It is an audit column to help track
the source system/user who created the record in the database table. This column will never be updated.

{% enddocs %}

{% docs rec_update_by %}

Column **rec_update_by** represents the process that updated the record. It is an audit column to help track
the source system/user who updated the record in the database table. This column is updated with a system/user 
name when one or more columns for this specific row is updated.

*NOTE:* when the row is initially created, this column will have the same system/user name as the **rec_create_by**

{% enddocs %}

{% docs effective_from %}

Column **effective_from** represents Audit column captures record effective from , which is current time stamp

{% enddocs %}

{% docs end_date %}

Column **end_date** is audit column captures record end date. 
*NOTE:* typically future date TO_DATE('9999-12-31','YYYY-MM-DD')

{% enddocs %}


{% docs hash_key %}

Column **hash_key** Audit column represents DBT generated hash key. It is calculated from business keys

{% enddocs %}

{% docs hashdiff %}

Column **hashdiff** Represents DBT generated (via DBT Vault module)  hashdiff column. This column tracks any change in the payload column of the satelite table. (similar to a checksum) This column tracks if there has been any change in payload

{% enddocs %}

{% docs source %}

Column **source** is audit column captures The record source of this key when first loaded

{% enddocs %}

{% docs etl_load_datetime %}

Column **etl_load_datetime** is audit column captures Time of the Load – This column indicates the ETL load timestamp.

{% enddocs %}