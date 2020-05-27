class Museum
  attr_reader :name, :exhibits, :patrons
  def initialize(name)
    @name     = name
    @exhibits = []
    @patrons  = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    recommendations = []
    @exhibits.each do |exhibit|
      recommendations << exhibit if patron.interests.include?(exhibit.name)
    end
    recommendations
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    exhibit_interest = {}
    @exhibits.each do |exhibit|
      @patrons.each do |patron|
        exhibit_interest[exhibit] += patron if patron.interests.include?(exhibit)
      end
    end
    exhibit_interest
  end

  def ticket_lottery_contestants(exhibit)
    contestants = []
    @patrons.each do |patron|
      contestants << patron if patron.interests.include?(exhibit.name) && patron.spending_money < exhibit.cost
    end
    contestants
  end

  def draw_lottery_winner(exhibit)
    if ticket_lottery_contestants(exhibit) == []
      nil
    else
      ticket_lottery_contestants(exhibit).sample.name
    end
  end
end
