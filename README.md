# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby Version

* System Dependencies

* Configuration

* Database Creation
Initialize database directory and start Postgres:
```shell
rake db:init
```

* Database Initialization
Existing .shp (and related) files in the `db/shpfiles/` directory will be 
  migrated into the `Locations` table. 

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
