
curl http://localhost:1335/api/fighters) | jq
curl http://localhost:1335/api/fighters -X GET | jq ".[0].name"
curl http://localhost:1335/api/fighters -X GET | jq "map(.name)"

curl -X POST -d '{"name": "35345345 63436463443", "weight": 713.5, "wins": 420, "losses": 69 }'  -H 'Content-type: application/json' http://localhost:1335/api/post/fighters | jq

