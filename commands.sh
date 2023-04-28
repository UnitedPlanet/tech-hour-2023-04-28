# Start basic deployment (10.16.0)
echo "Demo 1: start basic deployment"
pushd ./01-basic-deployment/
docker compose pull
docker compose up --always-recreate-deps --wait -d
popd
echo "Demo 1:complete"

# Update deployment to 11.0.0
echo "Demo 2: update deployment to 11.0.0"
pushd ./02-update-deployment/
docker compose pull
docker compose up --always-recreate-deps --wait -d
echo "Demo 2:complete"

# Export the portal and create a distributed deployment from it
echo "Demo 3: create distributed deployment from template"
echo "Download PM from http://localhost:1337/ now"
# pushd /home/ursl/Downloads/
# tar xzf portable-manager-linux.tar.gz
echo "Import resource template and export portal to /tmp/tech-hour-demo.zip"
# intrexx-manager/client/bin/linux/manager.sh
# popd
mkdir -p ../03-distributed-deployment-from-template/resource/portal
docker cp demo-standalone-intrexx-1:/tmp/tech-hour-demo.zip ../03-distributed-deployment-from-template/resource/portal/tech-hour-demo.zip
docker compose down -v
popd
pushd ./03-distributed-deployment-from-template/
echo "Delete internal/cfg/spring/00-standalone-context.xml from zip"
docker compose pull
docker compose up --always-recreate-deps --wait -d
echo "Demo 3:complete"

echo "Cleanup"
docker compose down -v
popd
