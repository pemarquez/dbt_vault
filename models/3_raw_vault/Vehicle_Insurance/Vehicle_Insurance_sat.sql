/* set yaml_metadata and endset are used for assigning variable ( key value pairs) */


{%- set yaml_metadata -%}
source_model: "vehicle_insurance_stage_vw"
src_pk: "vehicle_insurance_hk"
src_hashdiff: 
  source_column: "hashdiff"
  alias: "hashdiff"
src_payload:
      - "vehicle_insurance_id"
      - "Gender"
      - "Age"
      - "Driving_License"
      - "Region_Code"
      - "Previously_Insured"
      - "Vehicle_Age"
      - "Vehicle_Damage"
      - "Annual_Premium"
      - "Policy_Sales_Channel"
      - "Vintage"
      - "rec_create_date"
      - "rec_update_date"
      - "rec_create_by"
      - "rec_update_by"
src_eff: "effective_from"
src_ldts: "etl_load_datetime"
src_source: "source"
{%- endset -%}

/* fromyml() built-in jinja function  assigns values to variables */

{% set metadata_dict = fromyaml(yaml_metadata) %}

/*

Each component of a Satellite is described below.

Primary Key (src_pk)
A primary key (or surrogate key) which is usually a hashed representation of the natural key. For a Satellite, this should be the same as the corresponding Link or Hub PK, concatenated with the load timestamp.

Hashdiff (src_hashdiff)
This is a concatenation of the payload (below) and the primary key. This allows us to detect changes in a record (much like a checksum). For example, if a customer changes their name, the hashdiff will change as a result of the payload changing.

Payload (src_payload)
The payload consists of concrete data for an entity (e.g. A customer). This could be a name, a date of birth, nationality, age, gender or more. The payload will contain some or all of the concrete data for an entity, depending on the purpose of the satellite.

Effective From (src_eff) - optional
An effectivity date. Usually called EFFECTIVE_FROM, this column is the business effective date of a Satellite record. It records that a record is valid from a specific point in time. If a customer changes their name, then the record with their 'old' name should no longer be valid, and it will no longer have the most recent EFFECTIVE_FROM value.

Load date (src_ldts)
A load date or load date timestamp. This identifies when the record was first loaded into the database.

Record Source (src_source)
The source for the record. This can be a code which is assigned to a source name in an external lookup table, or a string directly naming the source system.
*/


{{ dbtvault.sat(src_pk=metadata_dict["src_pk"],
                src_hashdiff=metadata_dict["src_hashdiff"],
                src_payload=metadata_dict["src_payload"],
                src_eff=metadata_dict["src_eff"],
                src_ldts=metadata_dict["src_ldts"],
                src_source=metadata_dict["src_source"],
                source_model=metadata_dict["source_model"])   }}