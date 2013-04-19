require 'rubygems'
require 'sinatra'
require 'active_record'
require 'logger'

# Connect to database
ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml')))
ActiveRecord::Base.logger = Logger.new(STDOUT)

# Include models
Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each { |file| require file }

set scss: Proc.new { File.join(root, 'app', 'assets', 'stylesheets') }
set coffee: Proc.new { File.join(root, 'app', 'assets', 'javascripts') }
set :views, Proc.new { File.join(root, 'app', 'views') }
set :haml, format: :html5

get '/' do
  haml :index
end

get '/stylesheet/general.css' do
  scss :general
end
