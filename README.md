# PHP Docker utils

[![pipeline status](https://git.1drop.de/onedrop/php-docker-utils/badges/master/pipeline.svg)](https://git.1drop.de/onedrop/php-docker-utils/commits/master)

Builds images:
```
1drop/php-70-docker-utils
1drop/php-71-docker-utils
1drop/php-72-docker-utils
1drop/php-73-docker-utils
1drop/php-74-docker-utils
```

and tests them using [container structure tests](https://github.com/GoogleContainerTools/container-structure-test) before pushing them to [DockerHub](https://hub.docker.com/r/1drop).

## Utilities

**Code quality:**

* phpmd
* php-cs-fixer
* phpunit
* phpcpd
* phpstan
* phpcs

**Security:**

* security-checker

**Misc:**

* xml-lint

## Local building

```shell script
export PHP_VERSION="7.4"
export DOCKER_VERSION="18.09.6"
export DOCKER_COMPOSE_VERSION="1.25.4"
export GIT_LFS_VERSION="2.7.2"
export ANSISTRANO_ROLLBACK_VERSION="1.5.0"
export ANSISTRANO_DEPLOY_VERSION="1.12.0"
export IMAGE_VERSION=74
export NODE_VERSION=12
docker build \
  --build-arg PHP_VERSION=${PHP_VERSION} \
  --build-arg DOCKER_VERSION=${DOCKER_VERSION} \
  --build-arg GIT_LFS_VERSION=${GIT_LFS_VERSION} \
  --build-arg ANSISTRANO_DEPLOY_VERSION=${ANSISTRANO_DEPLOY_VERSION} \
  --build-arg ANSISTRANO_ROLLBACK_VERSION=${ANSISTRANO_ROLLBACK_VERSION} \
  --build-arg NODE_VERSION=${NODE_VERSION} \
  --no-cache -t 1drop/php-${IMAGE_VERSION}-docker-utils .
```

## Local testing

```shell script
container-structure-test test --image 1drop/php-74-docker-utils --config test.yaml
```
