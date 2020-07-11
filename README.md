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
* and then I got in the dashboard of my Aut0 Accoutn, for the created aplication settings : 

```bash
# .env
AUTH0_CLIENT_ID=N9Sa4YRY8hLnxLcTFqQM3Bfo32cQMMOY
AUTH0_DOMAIN=pegasusio.eu.auth0.com
AUTH0_CLIENT_SECRET=YOUR_CLIENT_SECRET
# the domain name depends on where you deployed and made available your app
export AUHT0_CALLBACK=http://2886795290-8000-cykoria04.environments.katacoda.com/callback

echo ''
echo " -- finally, and **very important** : "
echo " --   you must configure the Auth0 _Application_ you created, to allow one callback url, of value "
echo " --   the exact value of [${AUHT0_CALLBACK}]"
echo ''
```
* finally, and **very important** : you must configure the Auth0 _Application_ ypou created, to allow one callback url, the exact value of `${AUHT0_CALLBACK}`
