#!/bin/sh
# Set some environment variables for PostgreSQL

export PATH=/opt/gkh/postgresql/bin:$PATH
export PGDATA=/opt/gkh/postgresql/data
export PGDATABASE=postgres
export PGUSER=postgres
export PGPORT=5432
export PGPASSFILE=/opt/gkh/postgresql/pgpass
