require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'

class MuseumTest < MiniTest::Test
  def test_it_exists
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_instance_of Museum, dmns
  end

  def test_it_has_readable_attributes
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_equal 'Denver Museum of Nature and Science', dmns.name
    assert_equal [], dmns.exhibits
  end

  def test_it_can_add_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)

    expected = [{name: 'Gems and Minerals', cost: 0},
                {name: 'Dead Sea Scrolls', cost: 10}]

    assert_equal expected, dmns.exhibits
  end
end
