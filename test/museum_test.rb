require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'
require 'pry'

class MuseumTest < MiniTest::Test
  def test_it_exists
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_instance_of Museum, dmns
  end

  def test_it_has_readable_attributes
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_equal 'Denver Museum of Nature and Science', dmns.name
    assert_equal [], dmns.exhibits
    assert_equal [], dmns.patrons
  end

  def test_it_can_add_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)

    assert_equal [gems_and_minerals, dead_sea_scrolls], dmns.exhibits
  end

  def test_it_can_recommend_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")

    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("IMAX")

    assert_equal [gems_and_minerals, dead_sea_scrolls], dmns.recommend_exhibits(patron_1)
    assert_equal [imax], dmns.recommend_exhibits(patron_2)
  end

  def test_it_can_admit_patrons
    dmns = Museum.new("Denver Museum of Nature and Science")

    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)

    dmns.admit(patron_1)
    assert_equal [patron_1], dmns.patrons

    dmns.admit(patron_2)
    assert_equal [patron_1, patron_2], dmns.patrons
  end

  def test_it_displays_patrons_by_exhibit_interest
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1 = Patron.new("Bob", 20)
    patron_1.add_interest('Gems and Minerals')
    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest('Dead Sea Scrolls')
    patron_3 = Patron.new("Johnny", 5)
    patron_3.add_interest('Dead Sea Scrolls')

    expected = {gems_and_minerals => [patron_1],
                dead_sea_scrolls  => [patron_2, patron_3],
                imax              => []}

    assert_equal expected, dmns.patrons_by_exhibit_interest
  end

  def test_ticket_lottery_contestants_are_added
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1 = Patron.new("Bob", 0)
    patron_1.add_interest('Gems and Minerals')
    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest('Dead Sea Scrolls')
    patron_3 = Patron.new("Johnny", 5)
    patron_3.add_interest('Dead Sea Scrolls')

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    assert_equal [patron_3], dmns.ticket_lottery_contestants(dead_sea_scrolls)
    assert_equal [], dmns.ticket_lottery_contestants(gems_and_minerals)
  end

  def test_draw_lottery_winner
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1 = Patron.new("Bob", 0)
    patron_1.add_interest("Gems and Minerals")
    patron_1.add_interest("Dead Sea Scrolls")
    patron_2 = Patron.new("Sally", 20)
    patron_2.add_interest("Dead Sea Scrolls")
    patron_3 = Patron.new("Johnny", 5)
    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    dmns.ticket_lottery_contestants(dead_sea_scrolls)

    assert_equal patron_1.name || patron_3.name, dmns.draw_lottery_winner(dead_sea_scrolls)

    dmns.ticket_lottery_contestants(imax)
    assert_nil dmns.draw_lottery_winner(imax)
  end
end
