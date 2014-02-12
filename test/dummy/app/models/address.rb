class Address < ActiveRecord::Base
  acts_as_view do |vr|
    vr.add :city,[:locality,:city,:name] 
    vr.add :country,[:locality,:country,:name] 
  end
  belongs_to :locality
end
