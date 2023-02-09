#!/bin/bash

id="${1}"
name="${2}"

az ad sp create-for-rbac \
    --display-name="${name}" \
    --role="Contributor" \
    --scopes="/subscriptions/${id}" \
|| exit $?

# az ad sp delete --id 00000000-0000-0000-0000-000000000000
