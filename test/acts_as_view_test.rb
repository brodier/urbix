# urbix/test/acts_as_view_test.rb
 
require 'test_helper'
 
class ActsAsViewTest < MiniTest::Unit::TestCase 
  def test_an_address_as_a_view
    assert_respond_to Address,:view
  end
  
  def test_view_relations_class
    vr = Urbix::ActsAsView::ViewRelations.new(Mail)
    vr.add(:exp_city,[:exp, :locality,:city,:name])
    vr.add(:exp_country,[:exp, :locality,:country,:name])
    vr.add(:dst_city,[:dst, :locality,:city,:name])
    vr.add(:dst_country,[:dst, :locality,:country,:name])
    assert_equal ["cities.name as exp_city", "countries.name as exp_country", "cities_1.name as dst_city",
      "countries_1.name as dst_country"].sort,vr.select_clause.split(', ').sort
    assert_equal ["addresses", "addresses addresses_1", "cities", "cities cities_1", "countries", 
      "countries countries_1", "localities", "localities localities_1", "mails"].sort,vr.from_clause.split(', ').sort
    assert_equal ["addresses.locality_id=localities.id", "addresses_1.locality_id=localities_1.id", 
      "localities.city_id=cities.id", "localities.country_id=countries.id", 
      "localities_1.city_id=cities_1.id", "localities_1.country_id=countries_1.id", "mails.dst_id=addresses_1.id", 
      "mails.exp_id=addresses.id"].sort, vr.join_clause.split(' and ').sort
  end
end
