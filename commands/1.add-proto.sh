#!/bin/sh
curl http://localhost:9180/apisix/admin/protos/1 -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d "{ \"content\": \"$(sed 's/"/\\"/g' ../model/src/main/proto/model.proto)\" }"
