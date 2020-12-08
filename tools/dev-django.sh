#!/usr/bin/env bash

set -o errexit

root="$(dirname "$0")/.."
app="${root}/app"
venv="${root}/venv"

echo "Initializing database"
"${venv}/bin/python" "${app}/manage.py" wait_for_db
"${venv}/bin/python" "${app}/manage.py" migrate
"${venv}/bin/python" "${app}/manage.py" create_roles

if [[ -n "${ADMIN_USERNAME}" ]] && [[ -n "${ADMIN_PASSWORD}" ]] && [[ -n "${ADMIN_EMAIL}" ]]; then
  "${venv}/bin/python" "${app}/manage.py" create_admin \
    --username "${ADMIN_USERNAME}" \
    --password "${ADMIN_PASSWORD}" \
    --email "${ADMIN_EMAIL}" \
    --noinput \
  || true
fi

echo "Starting django"
"${venv}/bin/python" -u "${app}/manage.py" runserver "$@"
