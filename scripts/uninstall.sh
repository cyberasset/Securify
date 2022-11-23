#!/bin/bash

cat ../web/art/1.1.txt
echo "Uninstalling securify"

if [ "$EUID" -ne 0 ]
  then
  echo "Error uninstalling securify, Please run this script as root!"
  echo "Example: sudo ./uninstall.sh"
  exit
fi

echo "Stopping securify"
docker stop securify_web_1 securify_db_1 securify_celery_1 securify_celery-beat_1 securify_redis_1 securify_tor_1 securify_proxy_1

echo "Removing all Containers related to securify"
docker rm securify_web_1 securify_db_1 securify_celery_1 securify_celery-beat_1 securify_redis_1 securify_tor_1 securify_proxy_1
echo "Removed all Containers"

echo "Removing All volumes related to securify"
docker volume rm securify_gf_patterns securify_github_repos securify_nuclei_templates securify_postgres_data securify_scan_results securify_tool_config
echo "Removed all Volumes"

echo "Removing all networks related to securify"
docker network rm securify_securify_network

echo "Finished Uninstalling."
