class ImportParksFromShp < ActiveRecord::Migration[6.1]
  require 'rgeo/shapefile'

  def up
    Dir.glob(Rails.root.join('db', 'shpfiles', '*.shp')).select do |file_name|
      tmp_file = "#{File.dirname(file_name)}/tmp/#{File.basename(file_name)}"
      tmp_table = File.basename(file_name, '.*')
      puts " * Importing: \n"\
           " ---> From:  #{file_name}\n"\
           " ---> To:    #{tmp_file}\n"\
           " ---> Table: #{tmp_table}\n"
      drop_columns = `ogr2ogr -f "ESRI Shapefile" -dialect sqlite -sql "SELECT geometry, UNIT_NAME, CreationDa, DATE_EDIT FROM #{tmp_table}" '#{tmp_file}' '#{file_name}'`
      dump_data = `ogr2ogr -nlt PROMOTE_TO_MULTI -nln #{tmp_table} -f "PostgreSQL" PG:"host=127.0.0.1 dbname=Alpha_development" '#{tmp_file}'`

      # connection.execute "drop table if exists #{tmp_table}"
      connection.execute drop_columns
      connection.execute dump_data
      connection.execute <<-SQL
        insert into locations(name, site, created_at, updated_at)
          select UNIT_NAME, wkb_geometry, CreationDa, DATE_EDIT from #{tmp_table}
      SQL
      connection.execute "drop table #{tmp_table}"
    end
  end

  def down
    Location.delete_all
  end

end
