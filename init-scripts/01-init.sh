#!/bin/bash
set -e

# Import data from JSON file
mongoimport --host localhost --db myflix --collection videos --type json --file /docker-entrypoint-initdb.d/videos.json --jsonArray

# Clean up
rm /docker-entrypoint-initdb.d/videos.json
