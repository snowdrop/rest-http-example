#!/bin/bash
body='{
"request": {
  "message":"Build triggered because of quick_rest_springboot-tomcat change",
  "branch":"master"
}}'

curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Travis-API-Version: 3" \
  -H "Authorization: token $TRAVIS_API_TOKEN" \
  -d "$body" \
https://api.travis-ci.org/repo/obsidian-toaster%2Fplatform/requests