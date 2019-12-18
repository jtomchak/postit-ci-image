# Post It CI/CD Builder Image

## Build it
` docker build -t jtomchak/postitci .`

## Tag it
`docker tag #{Container Nummer} jtomchak/postitci:X.X.X`

## Publish it
`docker push jtomchak/postitci`


## Run it locally
- GOOGLE_ACCOUNT_KEY
  - is the service account auth json key from your gcloud account. Needs to have storage read/write access
- GOOGLE_PROJECT_ID
  - project id of the storage you're targeting
- USERNAME
  - this is used to name the specific storage bucket `#{USERNAME}.postit.blog`

- shell command  
`docker run -it --rm -e GOOGLE_ACCOUNT_KEY="$(< ~/.gcloud/keyfile.json)" -e GOOGLE_PROJECT_ID=post-it-services -e USERNAME=jesse postit/ci:latest`