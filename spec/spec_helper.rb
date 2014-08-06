require 'rspec'
require 'pg'
require 'doctor'
require 'specialty'
require 'insurance'
require 'patient'
require 'pry'

ATTRIBUTES = {"name" => 'name'}

DB = PG.connect({:dbname => 'doctor_office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctor *;")
    DB.exec("DELETE FROM specialty *;")
    DB.exec("DELETE FROM insurance *;")
    DB.exec("DELETE FROM patient *;")
  end
end
