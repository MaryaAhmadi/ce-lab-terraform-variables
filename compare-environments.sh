#!/bin/bash

echo "=== Development Environment ==="
echo "Bucket: mahmadiapp-bootcamp-dev-bucket"
aws s3api get-bucket-versioning --bucket mahmadiapp-bootcamp-dev-bucket
aws s3api get-bucket-tagging --bucket mahmadiapp-bootcamp-dev-bucket 2>/dev/null || echo "No tags or error"

echo -e "\n=== Production Environment ==="
echo "Bucket: mahmadiapp-bootcamp-prod-bucket"
aws s3api get-bucket-versioning --bucket mahmadiapp-bootcamp-prod-bucket
aws s3api get-bucket-tagging --bucket mahmadiapp-bootcamp-prod-bucket 2>/dev/null || echo "No tags or error"
