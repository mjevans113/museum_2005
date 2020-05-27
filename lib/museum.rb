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

  # def patrons_by_exhibit_interest
  #   exhibit_interest = {}
  #   @exhibits.each do |exhibit|
  #     exhibit_interest[exhibit] = []
  #   end
  #   @patrons.each do |patron|
  #
  #   end
  # end

  def ticket_lottery_contestants(exhibit)
    contestants = []
    @patrons.each do |patron|
      contestants << patron if patron.interests.include?(exhibit.name) && patron.spending_money < exhibit.cost
    end
    contestants
  end
end
