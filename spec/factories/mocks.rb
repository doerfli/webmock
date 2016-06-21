require 'factory_girl_rails'

FactoryGirl.define do
  factory :mock do
    id '87fb5727-0892-4962-af25-a157258bd54d'
    statuscode "200"
    contenttype "application/json"
    body ''
  end
end