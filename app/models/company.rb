class Company < ApplicationRecord
  include CompanySync
  has_many :employees
end
