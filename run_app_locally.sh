#!/bin/bash -e
export DATABASE_SCHEMA=hiring-success-case
export DATABASE_USER=$(whoami)
export DATABASE_PASSWORD=secret

rails s -b 0.0.0.0