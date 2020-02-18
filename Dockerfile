ARG PHP_VERSION
FROM webdevops/php:${PHP_VERSION}

# Add ansible and ansistrano
ARG ANSISTRANO_DEPLOY_VERSION
ARG ANSISTRANO_ROLLBACK_VERSION
RUN apt-install ansible \
    && ansible-galaxy install ansistrano.deploy,${ANSISTRANO_DEPLOY_VERSION} ansistrano.rollback,${ANSISTRANO_ROLLBACK_VERSION}

# Add git lfs
ARG GIT_LFS_VERSION
RUN wget -q -O git-lfs.tar.gz https://github.com/git-lfs/git-lfs/releases/download/v${GIT_LFS_VERSION}/git-lfs-linux-amd64-v${GIT_LFS_VERSION}.tar.gz \
    && mkdir git-lfs && tar xzf git-lfs.tar.gz -C git-lfs && cd git-lfs && ./install.sh && cd .. && rm -rf git-lfs*

# Add Docker
ARG DOCKER_VERSION
RUN wget -q -O docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
    && tar xzf docker.tgz && cp docker/* /usr/bin/ && rm -rf docker && rm docker.tgz
ARG DOCKER_COMPOSE_VERSION
RUN curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Add mysql certs and repos
COPY ./certs /tmp/certs
RUN apt-key add /tmp/certs/mysql.pub \
    && sh -c 'echo "deb http://repo.mysql.com/apt/debian/ stretch mysql-8.0" >> /etc/apt/sources.list.d/mysql.list' \
    && sh -c 'echo "deb http://repo.mysql.com/apt/debian/ stretch mysql-tools" >> /etc/apt/sources.list.d/mysql.list'

# Add nodejs and mysql-client (for Shopware)
ARG NODE_VERSION
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && apt-install dirmngr python-dateutil \
    && apt-install nodejs mysql-client


# Install utilities defined in composer.json globally
ENV PATH "/root/.composer/vendor/bin:$PATH"
COPY composer.json /root/.composer/composer.json
RUN composer global install --no-progress -ao --no-dev \
    && composer global update \
    && composer clearcache

# Cleanup
RUN docker-image-cleanup
