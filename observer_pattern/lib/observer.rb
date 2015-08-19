class Tile
    attr_reader :observers

    def initialize(attrs = {})
      @cursed = attrs.fetch(:cursed, false)
      @hero = attrs.fetch(:hero, nil)
      @observers = []
    end

    def add_observer(creature)
      @observers << creature
    end

    def cursed?
      @cursed
    end

    def notify_observers
      observers.each { |observer| observer.update }
    end

    def activate_curse
      notify_observers
    end
end

class Hero
  attr_reader :health

  def initialize
    @cursed = false
    @health = 10
  end

  def damage(hit)
    @health -= hit
  end

  def cursed?
    @cursed
  end

  def discovers(tile)
    if tile.cursed?
      @cursed = true 
      tile.add_observer(self)
    end
  end

  def update
    damage(4)
  end

end