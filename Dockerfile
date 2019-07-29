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

# Install utilities defined in composer.json globally
ENV PATH "/root/.composer/vendor/bin:$PATH"
COPY composer.json /root/.composer/composer.json
RUN composer global install --no-progress -ao --no-dev \
    && composer clearcache

# Cleanup
RUN docker-image-cleanup
