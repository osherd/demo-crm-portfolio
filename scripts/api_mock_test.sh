#!/bin/bash

BASE_URL="http://localhost:80/api/clients"

test_request() {
  local name=$1 method=$2 expected=$3 data=$4
  code=$(curl -s -o /dev/null -w "%{http_code}" -X $method "$BASE_URL" \
    -H "Content-Type: application/json" ${data:+-d "$data"})
  [[ $code -eq $expected ]] && echo "✅ $name: $code" || echo "❌ $name: $code (expected $expected)"
}

test_request "Create Character" POST 400 '{
  "id_": 3,
  "name": "Test",
  "email": "test.com",
  "company": "Test Dev",
  "website": "https://test.com"
}'

test_request "Confirm Creation" GET 200
