class Museum
  attr_reader :name, :exhibits
  def initialize(name)
    @name     = name
    @exhibits = []
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
end
