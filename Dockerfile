FROM google/cloud-sdk:slim AS build

# set up needed variables
ENV NODE_VERSION=12.x
ARG PROJECT_REPOSITORY_URL=https://github.com/jtomchak/postit-starter.git
ARG PROJECT_REPOSITORY_NAME=postit-starter


# install node-npm-yarn for builds
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -qq -y build-essential libpq-dev nodejs yarn 

# fetch start project and set working dir
RUN git clone ${PROJECT_REPOSITORY_URL} ${PROJECT_REPOSITORY_NAME} 
WORKDIR  "/${PROJECT_REPOSITORY_NAME}"


# install all dependencies needed for project
RUN yarn --frozen-lockfile --non-interactive


# set entry script to execute `yarn build` with env variables
COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /
ENTRYPOINT ["docker-entrypoint.sh"]