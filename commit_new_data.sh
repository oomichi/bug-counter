DOCKER_IMAGE="test/graph"
DOCKER_WORKER="make_graph"

git checkout master
git pull
./merge-counts-into-single-csv.sh
git add data/
git add graph/result.csv
git commit -m "Add new data"
git push origin master

# Create a new graph
FLAG=`docker ps -a | grep ${DOCKER_WORKER}`
if [ -z "${FLAG}" ]; then
    FLAG=`docker images | grep ${DOCKER_IMAGE}`
    if [ -z "${FLAG}" ]; then
        cd graph
        docker build -t ${DOCKER_IMAGE} .
        cd ..
    fi
    docker run --name ${DOCKER_WORKER} ${DOCKER_IMAGE}
fi

docker cp graph/result.csv ${DOCKER_WORKER}:result.csv
docker restart make_graph
rm tempest_bug_count.png
docker cp make_graph:tempest_bug_count.png tempest_bug_count.png
git add tempest_bug_count.png
git commit -m "Add new graph"
git push origin master

