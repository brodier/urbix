class Address < ActiveRecord::Base
  acts_as_view
  belongs_to :locality
end
