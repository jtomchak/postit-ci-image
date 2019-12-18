#!/bin/bash
trap 'exit' ERR

echo "<h3>Auth with GCloud</h3>"
echo ${GOOGLE_ACCOUNT_KEY} > account.json
gcloud auth activate-service-account --key-file=account.json
gcloud config set project ${GOOGLE_PROJECT_ID}


echo "<h3>Starting the build</h3>"

# echo "<h3>Checkout source code</h3>"
# git clone ${PROJECT_REPOSITORY_URL} ${PROJECT_REPOSITORY_NAME} 
# cd ${PROJECT_REPOSITORY_NAME}
# git checkout ${PROJECT_BRANCH}
# # Have rvm recheck ruby version
# cd .

echo "<h3>Dependencies</h3>"

# default language dependencies
echo Exporting NODE_ENV
export NODE_ENV=production
# echo Exporting USERNAME HERE
# node -v
# npm -v


# echo "<h3>Setup node_modules</h3>"
# # setup project modules
# yarn --frozen-lockfile --non-interactive

echo "<h3>Build</h3>"
# default language test
yarn build

echo "<h3>Copy to GCloud Storage</h3>"
ls -al public/
gsutil -m rsync -d -r public/ gs://$USERNAME.postit.blog/

echo "<h3>Set index.html for webservice</h3>"
gsutil web set -m index.html -e index.html gs://$USERNAME.postit.blog/

exec "$@"
