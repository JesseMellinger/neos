require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative 'near_earth_objects'

class NearEarthObjectsTest < Minitest::Test
  def test_a_date_returns_a_list_of_neos
    results = NearEarthObjects.new('2019-03-30').get_neos_by_date()
    
    assert_equal '(2011 GE3)', results[:asteroid_list][0][:name]
  end
end
