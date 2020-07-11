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