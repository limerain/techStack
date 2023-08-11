# APIS
- API 등록하기:
```shell
curl -v -H "x-tyk-authorization: foo" \
  -s \
  -H "Content-Type: application/json" \
  -X POST \
  -d '{
    "name": "Hello-World",
    "slug": "hello-world",
    "api_id": "Hello-World",
    "org_id": "1",
    "use_keyless": true,
    "auth": {
      "auth_header_name": "Authorization"
    },
    "definition": {
      "location": "header",
      "key": "x-api-version"
    },
    "version_data": {
      "not_versioned": true,
      "versions": {
        "Default": {
          "name": "Default",
          "use_extended_paths": true
        }
      }
    },
    "proxy": {
      "listen_path": "/hello-world/",
      "target_url": "http://echo.tyk-demo.com:8080/",
      "strip_listen_path": true
    },
    "active": true
}' http://localhost:8080/tyk/apis | python -mjson.tool
```
- API reload: `curl -H "x-tyk-authorization: foo" -s http://localhost:8080/tyk/reload/group`
- 등록된 API 받아오기: `curl -H 'x-tyk-authorization: foo' localhost:8080/tyk/apis`
- test api call: `curl -H "x-tyk-authorization: foo" -s http://localhost:8080/hello-world/get`

# gRPCs
- gRPC 등록하기:
```shell
curl -H "x-tyk-authorization: foo" \
  -sk \
  -H "Content-Type: application/json" \
  -X POST \
  -d '{
    "name": "Hello-World",
    "slug": "hello-world",
    "api_id": "Hello-World",
    "org_id": "1",
    "use_keyless": true,
    "auth": {
      "auth_header_name": "Authorization"
    },
    "definition": {
      "location": "header",
      "key": "x-api-version"
    },
    "version_data": {
      "not_versioned": true,
      "versions": {
        "Default": {
          "name": "Default",
          "use_extended_paths": true
        }
      }
    },
    "proxy": {
      "enable_load_balancing": true,
      "listen_path": "/message.NotificationService/BidirectionalStreaming",
      "transport": {
        "ssl_insecure_skip_verify": true,
        "ssl_force_common_name_check": false
      },
      "target_url": "https://172.33.67.236:50051",
      "target_list": [
        "https://172.33.67.236:50051",
        "https://172.33.90.162:50051"
      ],
      "strip_listen_path": false
    },
    "active": true
}' https://localhost:8080/tyk/apis && curl -H "x-tyk-authorization: foo" -sk https://localhost:8080/tyk/reload/group
```

`/helloworld.Greeter/SayHello`
`"listen_path": "/message.NotificationService/BidirectionalStreaming",`

- API 삭제: `curl -H "x-tyk-authorization: foo" -X DELETE http://localhost:8080/tyk/apis/Hello-World`