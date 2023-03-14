
# Welcome to Data Vault curation example DBT Code repository!
*********************************************
*********************************************

This repository contains DBT(Data Build Tool) application code. 
For DBT specific documentation, please refer https://docs.getdbt.com/.

It is highly recommended to go through this [free dbt course] (https://courses.getdbt.com/collections)



## Cloud 9 Setup for first time use:
**********************************

> Cloud 9 is an integrated development platform.Code editor,git,AWS-CLI,Python 
installation is pre-packaged with cloud 9 environment. However, in order to 
enrich the environment for DBT development, please follow below steps.

> Please ** note that these steps are to be performed for the first time only **. Cloud 9 
environment is not ephemeral and retains the state. Unless the environment is lost 
accidentally, the initial configurations will be retained for the entire lifecycle of
the Cloud 9 environment. 

```
sudo amazon-linux-extras list 
sudo amazon-linux-extras enable 44 
sudo yum install python38 
mkdir dbt_config
PROFILES_DIR=$(pwd)/dbt_config
sudo touch /etc/profile.d/dbt_config.sh
echo "PROFILES_DIR=$PROFILES_DIR"| sudo tee /etc/profile.d/dbt_config.sh
source /etc/profile.d/dbt_config.sh
virtualenv --python=python3.8 dbtEnv
source dbtEnv/bin/activate
pip install -r requirements.txt
```


### At this point the Cloud 9 environment is ready for DBT development.

## use below DBT commands to compile, test & run the models:
*****************************************************

> Refer to this link for DBT  commands and their relevant flags  https://docs.getdbt.com/reference/dbt-commands

1. To compile the DBT model use following commands. Note that $PROFILES_DIR  environment variable is set by running source /etc/profile.d/dbt_config.sh
```
> To compile all models 
> dbt compile --profiles-dir=$PROFILES_DIR
> To compile specific model  
> dbt compile  --select tag:<tag name> --profiles-dir=$PROFILES_DIR
> example : dbt compile  --select tag:Vehicle_Insurance--profiles-dir=$PROFILES_DIR
```
2. To test the DBT models use following commands 
```
> To test all models 
> dbt test --profiles-dir=$PROFILES_DIR
> To test specific model  
> dbt test  --select tag:<tag name> --profiles-dir=$PROFILES_DIR
> example : dbt test  --select tag:Vehicle_Insurance--profiles-dir=$PROFILES_DIR
```
3. To run the DBT models use following commands 
```
> To run all models 
> dbt run --profiles-dir=$PROFILES_DIR
> To run specific model  
> dbt run  --select tag:<tag name> --profiles-dir=$PROFILES_DIR
> example : dbt run  --select tag:Vehicle_Insurance--profiles-dir=$PROFILES_DIR
> you can also run specific model by passing -m <model name>
> dbt run  -m src_Vehicle_Insurance --profiles-dir=$PROFILES_DIR
```

4. To generate documentation for DBT models use following commands 
```
> To generate documentation for all models 
> dbt docs generate --profiles-dir=$PROFILES_DIR
> To generate documentation specific model  
> dbt docs generate  --select tag:<tag name> --profiles-dir=$PROFILES_DIR
> example : dbt docs generate --select tag:Vehicle_Insurance--profiles-dir=$PROFILES_DIR

```

5. Cleaning DBT targets 
```
> dbt clean is a utility function that deletes all folders specified in the clean-targets list specified in dbt_project.yml. 
> Use dbt clean before generating documentation as it cleans all target content 
> dbt clean 

```





#  curation DBT model’s overview

## Model Organization  
Our models organized into following categories:

| Category | Description                                             |
|----------|---------------------------------------------------------|
| 1_landing  | Contains models with source data. This is generally a landing zone for data flowing into the Data Vault.        |
| 2_stage_vault    | Contains models which clean and standardize data |
| 3_raw_vault  | The Raw Vault is where your main data vault entities stay. These include (Hubs, Satellites, Links).      |
| 4_bus_vault    | The Business Vault is optional and is an extension of a Raw Vault that applies selected business rules, calculations, logic |
| 5_mart  | Marts are where valuable information is finally delivered to the business users typically through reports or dashboards.       |
  
Things to note:
- There are different types of models
that typically exist in each of the above categories.  
See [Model Layers](#model-layers) for more information. 


## Model Layers
- Only models in `1_landing` should select from [sources](https://docs.getdbt.com/docs/building-a-dbt-project/using-sources)
- Models not within the `1_landing` folder should select from [refs](https://docs.getdbt.com/reference/dbt-jinja-functions/ref).
- The following are the DAG stages that we tend to utilize:


  | dag_stage | Typically found in | description                                                        |
  |-----------|--------------------|--------------------------------------------------------------------|
  | _seed     | 1_landing/1_seed             |  Indicates a data set created from `dbt seed`. |
  | _stg_vault      | /models/2_stage_vault    |  Indicates a data set that is being cleaned and standardized.  it represents the 1:1 relationship between the source and first layer of models.  |  
  | _raw_vault      | /models/3_raw_vault    |  The Raw Vault is where your main data vault entities stay. These include (Hubs, Satellites, Links).  Data is transferred from the staging area into the raw vault.  There should be no business rules applied to the data when ingestion from raw to staging is happening.  Essentially, the Raw Vault is the raw, unfiltered data from the source, loaded into Hubs, Links, and Satellites based on Business Keys. |  
  | _bus_vault      | /models/4_bus_vault     |  The Business Vault is optional and is an extension of a Raw Vault that applies selected business rules, calculations, logic, and other query assistance functions in order to assist reporting and user accessibility.  |
  | _mart     | /models/5_mart      |   Marts are where valuable information is finally delivered to the business users typically through reports or dashboards.  Indicates a final data which is robust, versatile, and ready for consumption. Typically marts contains facts and dimension tables:<ul>A fact in data warehousing describes quantitative transactional data like measurements, metrics, or the values ready for analysis.Dimension Tables hold the descriptive information for all related fields that are included in the fact table’s records. </ul>  |


## Model File Naming standards for PHD DaaS

Standards used in PHD DBT models: 
- System-based names, e.g., tables and table column names, are denoted in Consolas font:  load_date. 
- All objects should have a prefix to indicate their DAG stage in the flow.  
  See [Model Layers](#model-layers) for more information.
- All objects should be singular.  
  Example: `Vehicle_Insurance_stage_vw.sql` vs. `Vehicle_Insurances_stage_vw.sql`


## Levels 
- The first level must represent the data source, e.g., eicr, calredie, cair.  

- The second level must represent dbt stage ( ex: stage, raw_vault,bus_vault or _mart)

- The third level must identify the dataset, e.g., for the “Vehicle_Insurance ” 

- - Each top-level configuration should use a separate `.yml` file (i.e, sources, models)
  Example:
  ```bash
  phd-analytics -- first level data source 
  ├── 1_landing
  └── 2_stage_vault -- second level
      └── Vehicle_Insurance -- Third level 
          ├── Vehicle_Insurance_stage_vw.md
          ├── Vehicle_Insurance_stage_vw.yml
          ├── Vehicle_Insurance_stage_vw.sql
          ├── src_Vehicle_Insurance_vw.sql
          ├── src_Vehicle_Insurance_vw.yml
          ├── src_Vehicle_Insurance_vw.md -- Every yml file must have documentation file 

  ```


- All models should use the naming convention `<source>_<stage>__<additional_context>`.


    Examples:
    - Vehicle_Insurance_stage_vw.sql
    - Vehicle_Insurance_hub.sql
    - Vehicle_Insurance_sat.sql
    - Vehicle_Insurance_dim.sql

