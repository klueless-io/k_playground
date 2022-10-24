# frozen_string_literal: true

module Directors
  class Nuxt3GenesisBuilder
    attr_reader :dom

    def initialize
      @dom = {
        app: {}
      }
    end

    def app
      dom << { name: name }

      self
    end
  end
end
