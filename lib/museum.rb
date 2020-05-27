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
end
