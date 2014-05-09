require 'test_helper'

class UrbixTest < ActiveSupport::TestCase
  fixtures :all
  test "truth" do
    assert_kind_of Module, Urbix
  end
end
