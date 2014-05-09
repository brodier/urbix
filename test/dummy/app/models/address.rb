class Address < ActiveRecord::Base
  belongs_to :locality

  acts_as_view do |vr|
    vr.add :city,[:locality,:city,:name] 
    vr.add :country,[:locality,:country,:name] 
  end
end
