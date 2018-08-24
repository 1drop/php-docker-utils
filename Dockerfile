ARG PHP_VERSION
ARG GIT_LFS_VERSION
ARG ANSISTRANO_DEPLOY_VERSION
ARG ANSISTRANO_ROLLBACK_VERSION

FROM webdevops/php:${PHP_VERSION}

# Add git lfs
RUN curl -Lo git-lfs.tar.gz https://github.com/git-lfs/git-lfs/releases/download/v${GIT_LFS_VERSION}/git-lfs-linux-amd64-${GIT_LFS_VERSION}.tar.gz \
    && tar xzf git-lfs.tar.gz && cd git-lfs-${GIT_LFS_VERSION} && ./install.sh && cd .. && rm -rf git-lfs*
# Add ansible and ansistrano
RUN apt-install ansible \
    && ansible-galaxy install ansistrano.deploy,${ANSISTRANO_DEPLOY_VERSION} ansistrano.rollback,${ANSISTRANO_DEPLOY_VERSION}
# Install utilities defined in composer.json globally
ENV PATH "/root/.composer/vendor/bin:$PATH"
COPY composer.json /root/.composer/composer.json
RUN composer global install -ao --no-dev \
    && composer clearcache
