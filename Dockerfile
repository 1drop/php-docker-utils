ARG PHP_VERSION
ARG git_lfs_version
ARG ANSISTRANO_DEPLOY_VERSION
ARG ANSISTRANO_ROLLBACK_VERSION

FROM webdevops/php:${PHP_VERSION}

# Add git lfs
RUN wget -O git-lfs.tar.gz https://github.com/git-lfs/git-lfs/releases/download/v${git_lfs_version}/git-lfs-linux-amd64-${git_lfs_version}.tar.gz \
    && tar xzf git-lfs.tar.gz && cd git-lfs-${git_lfs_version} && ./install.sh && cd .. && rm -rf git-lfs*
# Add ansible and ansistrano
RUN apt-install ansible \
    && ansible-galaxy install ansistrano.deploy,${ANSISTRANO_DEPLOY_VERSION} ansistrano.rollback,${ANSISTRANO_DEPLOY_VERSION}
# Install utilities defined in composer.json globally
ENV PATH "/root/.composer/vendor/bin:$PATH"
COPY composer.json /root/.composer/composer.json
RUN composer global install -ao --no-dev \
    && composer clearcache
