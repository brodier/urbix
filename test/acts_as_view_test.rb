# urbix/test/acts_as_view_test.rb
 
require 'test_helper'
 
class ActsAsViewTest < MiniTest::Unit::TestCase 
  def test_an_address_as_a_view
    assert_respond_to Address,:view
  end

  def test_an_address_view_attributes
    assert_equal [:city,:country],Address.view
  end

end
