# frozen_string_literal: true

namespace :db do
  require 'rake/file_utils'
  desc 'Creates and starts Postgres database from tmp directory.'
  task init: :environment do
    path = 'tmp/storage/pg_db/'
    sh %(mkdir #{path}) unless File.directory?(path)
    sh %(initdb #{path}) unless File.directory?(path)
    sh %(pg_ctl -D #{path} -l logfile start > /dev/null 2>&1) do |ok, res|
      unless ok
        puts 'Postgres already running.' if res.exitstatus.eql? 1
      end
    end
  end
end
