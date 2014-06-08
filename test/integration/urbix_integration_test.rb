require 'test_helper'

describe "urbix integration" do
  it "provides urbix.js on the asset pipeline" do
    visit '/assets/urbix.js'
    page.text.must_include 'var UrbixAsset = {};'
  end

  it "provides urbix.css on the asset pipeline" do
    visit '/assets/urbix.css'
    page.text.must_include '.urbix {'
  end
end
