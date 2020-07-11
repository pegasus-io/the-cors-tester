# node express demo app - whatabyte food portal

this is a website created with node & express, using pug (updated jade) for templating.
the goal is to connect to auth0.com for user authentication.

[tutorial link](https://auth0.com/blog/create-a-simple-and-stylish-node-express-app/)

# How to start

* git clone and in the root older, inside a nodejs environment, run this :

```bash
export DESIRED_VERSION=HEAD
git clone https://github.com/pegasus-io/the-cors-tester
cd ./the-cors-tester
git checkout ${DESIRED_VERSION}

# the domain
export AUTH0_DOMAIN=auth0.pegasusio.io
# the clientID
export AUTH0_CLIENT_ID=pegasustest
# the clientSecret
export AUTH0_CLIENT_SECRET=ver7S3cr3t
# callbackURL
export AUTH0_CALLBACK_URL=https://someservice.pegasusio.io:8459/ether
npm i && npm run dev
```

* I created an account on Auth0 public website, to get free features of their SASS, then I created an _Application_, standing for my running application instance (every instacne shoudl havee its own _Application_) :
* and then I got in the dashboard of my `Auth0` Account, for the created aplication settings :

```bash
# .env
export AUTH0_CLIENT_ID=N9Sa4YRY8hLnxLcTFqQM3Bfo32cQMMOY
export AUTH0_DOMAIN=pegasusio.eu.auth0.com
export AUTH0_CLIENT_SECRET=YOUR_CLIENT_SECRET
# the domain name depends on where you deployed and made available your app
export AUTH0_CALLBACK_URL=http://2886795290-8000-cykoria04.environments.katacoda.com/callback

echo ''
echo " -- finally, and **very important** : "
echo " --   you must configure the Auth0 _Application_ you created, to allow one callback url, of value "
echo " --   the exact value of [${AUHT0_CALLBACK}]"
echo ''
```
* finally, and **very important** : you must configure the `Auth0` _Application_ you created, to allow one callback url, the exact value of `${AUHT0_CALLBACK}`
* Right, the configuration I provide here about `Auth0` needs a fix, but it's not what we care about :
  * we care about making the express server manage CORS :
    * it will accept cross origins `sub.domain1.com` and `sub.domain2.com`
    * it will reject https://randomuser.me/api
    * that for all HTTP methods, `GET` `POST` `PUT` `PATCH` `DELETE`.
  * and at the same time, in main page, we want to add some HTML :
    * an image loaded from a cross origin
    * `<img href="https://randomuser.me/api/portraits/med/women/18.jpg">a beautiful cross origin image</img>`


# K8S Deployment

* create your Kubernetes Image pull secrets (to deploy your image)
  * gitlab registry (you need to create a personal access token with `read_registry`/`write_registry` **and `api` thoughit is a known gitlab.com issue**)
```bash
export DESIRED_VERSION=feature/k8s-deployment
git clone git@github.com:pegasus-io/the-cors-tester.git
cd the-cors-tester/
git checkout ${DESIRED_VERSION}

rm -fr ~/.docker
docker login -u <username> registry.gitlab.com
#

# then execute this to re-create the image pull secret for the test runner deployment
kubectl delete secret glab-personal-access-token
kubectl create secret generic glab-personal-access-token \
    --from-file=.dockerconfigjson=$HOME/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson
```
  * quay.io registry (you need to create a personal access token with `read_registry`/`write_registry` **and `api` thoughit is a known gitlab.com issue**)
```bash
export DESIRED_VERSION=feature/k8s-deployment
git clone git@github.com:pegasus-io/the-cors-tester.git
cd the-cors-tester/
git checkout ${DESIRED_VERSION}

rm -fr ~/.docker

docker login -u <username> quay.io
#

# then execute this to re-create the image pull secret for the test runner deployment
kubectl delete secret quay-access-token
kubectl create secret generic quay-access-token \
  --from-file=.dockerconfigjson=$HOME/.docker/config.json \
  --type=kubernetes.io/dockerconfigjson
```
* docker build the image for your deployment :

```bash
export DESIRED_VERSION=feature/k8s-deployment
git clone git@github.com:pegasus-io/the-cors-tester.git
cd the-cors-tester/
git checkout ${DESIRED_VERSION}

export APP_SRC_CODE_GIT_COMMIT_ID="cvladt44ie41ofU"
# The app that is going to run : the Git commit ID of its source code
export TEST_RUNNER_GIT_COMMIT_ID="0.0.2-alpha"
export DOCKER_TAG="cors_air-${APP_SRC_CODE_GIT_COMMIT_ID}"
export OCI_GUN="registry.gitlab.com/second-bureau/gravitee/cors_air.git:${DOCKER_TAG}"
export OCI_GUN="registry.quay.io/gravitee/cors_air.git:${DOCKER_TAG}"

echo "[OCI_GUN=${OCI_GUN}]"

docker build -t jbl/cors_air .
#
docker tag jbl/cors_air ${OCI_GUN}

docker push ${OCI_GUN}
```

* Create your `Auth0` secret :

```bash
export DESIRED_VERSION=feature/k8s-deployment
git clone git@github.com:pegasus-io/the-cors-tester.git
cd the-cors-tester/
git checkout ${DESIRED_VERSION}
k8s/auth0-secret.sh
```

* and deploy :

```bash
kubectl apply -f k8s/pod.yaml
```
