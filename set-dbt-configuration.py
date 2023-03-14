import boto3
import json
import yaml
from collections import defaultdict
import os.path
import subprocess
import argparse
from pydash import _ 
try:
    
    parser = argparse.ArgumentParser(description='Set DBT Configuration.')
    parser.add_argument('--configurtion-directory',required=True, type=str,help='Please provide fully qualified DBT Cinfig Directory path')
    parser.add_argument('--run-environment',required=True,type=str,help='Please provide the environment where the DBT code will run. Allowed values are dev,qa,uat,prod')
    parser.add_argument('--application-name',required=True,type=str,help='Please provide the application anme which will run the DBT models. Allowed values are dev,qa,uat,prod')
    parser.add_argument('--client-name',required=True,type=str,help='Please provide the client name who owns the application' )
    args = parser.parse_args()
    ssmClient=boto3.client("ssm")
    response=ssmClient.get_parameters_by_path(
      Path=f'/{args.client_name}/app/{args.application_name}/config/dbt',
      WithDecryption=True
      )
    # # Default Paramset to hold config values
    paramSet={}
    # #Parameter Dict stores the parameter store parameter values
    paramDict=dict(list(map(lambda s: (s["Name"].split('/')[-1], int(s["Value"]) if  s["Value"].isnumeric() else s["Value"] ) ,response["Parameters"])))
    _.set(paramSet, f'phd_analytics.outputs.{args.run_environment}',paramDict)
    _.set(paramSet,'phd_analytics.target',args.run_environment)
    #print(yaml.dump(paramSet,indent=3))
    # Populate the DBT profiles file from Parameter Store
    with open(os.path.join(args.configurtion_directory,'profiles.yml'), 'w') as file:
        documents = yaml.dump(paramSet,file,indent=3)
except Exception as error:
    print(error)
    raise error
    
          


