# README

## Database Creation
Initialize database directory and start Postgres:
```shell
rake db:init
```

## Database Initialization
Existing .shp (and related) files in the `db/shpfiles/` directory will be 
  migrated into the `Locations` table. 

## Deployment Instructions

