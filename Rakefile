require 'active_support/core_ext/string/inflections'
require 'active_record'
require 'yaml'

task :environment do
  ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml')))
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

namespace :db do
  task migrate: :environment do
    desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
  end

  task :create_migration do
    desc "Create new migration. Set name of the migration with NAME=migration_name"
    begin
      # If name is set
      if ENV['NAME']
        filename = "#{Time.now.to_i}_#{ENV['NAME'].gsub(' ', '_')}.rb"

        File.open("db/migrate/#{filename}", 'w') do |file|
          migration = <<-MIGRATION
class #{ENV['NAME'].gsub(' ', '_').camelize} < ActiveRecord::Migration
  def change
  end
end
          MIGRATION
          file.write(migration)
        end
        puts "migration #{filename} was created"
      # If name is not set
      else
        puts "you need set NAME for migration"
      end
      # If failed to create migration
    rescue
      puts "migration #{filename} failed to create"
    end
  end
end

namespace :run do
  task admin: :environment do
    require 'rear'
    # Include models
    Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each { |file| require file }
    Rear.run server: :Thin, port: 2424
  end
end
