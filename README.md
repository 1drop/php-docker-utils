# PHP Docker utils

[![pipeline status](https://git.1drop.de/onedrop/php-docker-utils/badges/master/pipeline.svg)](https://git.1drop.de/onedrop/php-docker-utils/commits/master)

Builds images:
```
1drop/php-70-docker-utils
1drop/php-71-docker-utils
1drop/php-72-docker-utils
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
