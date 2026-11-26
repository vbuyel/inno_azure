#!/usr/bin/env bash
set -euo pipefail

STATE_FILE="${MOCK_AZ_STATE_FILE:-/tmp/mock-az-rg-state.json}"
SUBSCRIPTION_ID="00000000-0000-0000-0000-000000000000"

cmd="${1:-}"
subcmd="${2:-}"
shift 2 || true

case "${cmd} ${subcmd}" in
  "account show")
    cat <<EOF
{
  "environmentName": "AzureCloud",
  "id": "${SUBSCRIPTION_ID}",
  "isDefault": true,
  "name": "Mock-Azure-Subscription",
  "state": "Enabled",
  "user": {
    "name": "mock-user@example.com",
    "type": "user"
  }
}
EOF
    ;;

  "group create")
    name=""
    location=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --name|-n) name="$2"; shift 2 ;;
        --location|-l) location="$2"; shift 2 ;;
        *) shift ;;
      esac
    done
    if [[ -z "${name}" || -z "${location}" ]]; then
      echo "Usage: mock-az.sh group create --name <name> --location <location>" >&2
      exit 1
    fi
    rg_id="/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${name}"
    cat > "${STATE_FILE}" <<EOF
{
  "id": "${rg_id}",
  "location": "${location}",
  "managedBy": null,
  "name": "${name}",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
EOF
    cat "${STATE_FILE}"
    ;;

  "group show")
    name=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --name|-n) name="$2"; shift 2 ;;
        *) shift ;;
      esac
    done
    if [[ ! -f "${STATE_FILE}" ]]; then
      echo "ERROR: (ResourceGroupNotFound) Resource group '${name}' could not be found." >&2
      exit 3
    fi
    cat "${STATE_FILE}"
    ;;

  "group delete")
    name=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --name|-n) name="$2"; shift 2 ;;
        --yes|-y) shift ;;
        *) shift ;;
      esac
    done
    if [[ ! -f "${STATE_FILE}" ]]; then
      echo "ERROR: (ResourceGroupNotFound) Resource group '${name}' could not be found." >&2
      exit 3
    fi
    rm -f "${STATE_FILE}"
    echo "Deleted mock resource group '${name}'."
    ;;

  *)
    echo "Unsupported mock command: ${cmd} ${subcmd}" >&2
    exit 1
    ;;
esac
