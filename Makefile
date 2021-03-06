docker_name := ax4docker/ax_tarantool
docker_tag  := latest
container_name := ax_tarantool_instance
src_dir := src
run_flags := --rm -it -d

tarantool_log_file := tarantool.log

PORT := 5000

docker:
	docker build -t ${docker_name}:${docker_tag} -f Dockerfile ./
	
run:
	docker run ${run_flags} --name ${container_name} \
		-p ${PORT}:5000 \
		-e PORT=5000 \
		--net=host \
        ${docker_name}:${docker_tag}

stop:
	docker stop ${container_name}

nolan:
	docker exec --it  ${container_name} /bin/bash

log:
	docker exec -it  ${container_name}  cat ${tarantool_log_file}

tests:
	python test/tests.py

heroku-tests:
	python test/tests.py heroku

heroku-log:
	heroku logs --tail --app key-value-tarantool
