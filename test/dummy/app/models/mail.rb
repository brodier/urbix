class Mail < ActiveRecord::Base
  belongs_to :exp, class_name: "Address"
  belongs_to :dst, class_name: "Address"
  acts_as_view do |rel|
    rel.add :exp_city, [:exp,:locality,:city,:name]
    rel.add :exp_country, [:exp,:locality,:country,:name]
    rel.add :dst_city, [:dst,:locality,:city,:name]
    rel.add :dst_city, [:dst,:locality,:country,:name]
  end
end
