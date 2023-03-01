#!/bin/sh
curl http://localhost:9180/apisix/admin/routes/1 -H 'X-API-KEY: edd1c9f034335f136f87ad84b625c8f1' -X PUT -d '
{
    "uri": "/helloservice/sayhello",
    "plugins": {
        "grpc-transcode": {
            "proto_id": "1",
            "service": "ch.frankel.blog.grpc.model.HelloService",
            "method": "SayHello"
        },
        "serverless-pre-function": {
            "phase": "rewrite",
            "functions" : [
                "return function(conf, ctx)
                    local core = require(\"apisix.core\")
                    if not ngx.var.arg_name then
                        local uri_args = core.request.get_uri_args(ctx)
                        uri_args.name = \"world\"
                        ngx.req.set_uri_args(uri_args)
                    end
                end"
            ]
        }
    },
    "upstream": {
        "scheme": "grpc",
        "nodes": {
            "server:9090": 1
        }
    }
}'
