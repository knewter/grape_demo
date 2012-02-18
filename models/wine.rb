class Wine
  include Mongoid::Document
  field :name
  field :grapes
  field :country
  field :region
  field :year
  field :picture
  field :description
end
