#!/usr/bin/env bash
#
# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: 2026 BrightCodeCompany OÜ
#

imageRepo=ghcr.io/novamap-health/engine
imageTag=4.6.0-alpine-jre

digest=$(docker buildx imagetools inspect "$imageRepo:$imageTag" --raw \
  | jq -r '.manifests[] | select(.platform.os == "linux" and .platform.architecture == "amd64") | .digest')

echo "Got digest: $digest"
startTime=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

docker scout cves "$imageRepo@$digest" --ignore-base --only-severity critical,high --format sarif -o sarif.json

# Requires at least Node 26
node render-report.ts "$imageTag" "$digest" "$startTime"
