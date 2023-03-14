#!/bin/sh
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
python ./set-dbt-configuration.py --configurtion-directory=./dbt_config --run-environment dev --application-name phd-analytics --client-name hhs-phd