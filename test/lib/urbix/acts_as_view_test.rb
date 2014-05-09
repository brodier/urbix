# urbix/test/acts_as_view_test.rb
 
require 'test_helper'
 
class ActsAsViewTest < ActiveSupport::TestCase
  fixtures :all
  
  test "Address respond to view" do
    assert_respond_to Address,:view
  end
  
  test "View Relations Class on Mail and Address model" do
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
  
  test "Mail View method" do
    # view should return same record
    assert_equal Mail.all.collect{|m| m.content}.sort,Mail.view.collect{|m| m.content}.sort
    # Check view attributes
    assert_equal Mail.view.first.attributes.keys,  ["id", "content", "exp_id", 
    "dst_id", "created_at", "updated_at", "exp_city", "exp_country", "dst_city",
    "dst_country"]
    assert_equal Mail.view.collect{|m| 
      [m.exp_city,m.exp_country,m.dst_city,m.dst_country]
    }.sort , Mail.all.collect{|m| 
      [ m.exp.locality.city.name,m.exp.locality.country.name,
        m.dst.locality.city.name,m.dst.locality.country.name]
    }.sort
  end
  
  test "Address View Method" do
    assert_equal Address.view.first.attributes.keys.sort,  ["id", "address", "locality_id", 
    "city", "country", "created_at", "updated_at"].sort
  end
  
end
