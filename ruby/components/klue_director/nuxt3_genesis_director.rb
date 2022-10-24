# frozen_string_literal: true

module Directors
  # Composite Design Pattern: https://refactoring.guru/design-patterns/composite
  class Nuxt3GenesisDirector
    class << self
      def init
        new
      end
    end

    include KLog::Logging

    attr_reader :build_dom

    # Parent allows upwards navigation to parent
    attr_reader :parent

    # Apps allow downwards navigation plus access to sub-apps
    attr_reader :apps

    def initialize(**opts)
      @on_exist = opts[:on_exist] || :skip # %i[skip write compare]

      @build_dom = Directors::Nuxt3GenesisBuilder.new
    end

    # Move into Base Class
    def attach_parent(parent)
      @parent = parent
    end

    def navigate_parent
      parent.nil? ? self : parent
    end

    def root?
      parent.nil?
    end

    # Implement as needed (Implement is not provided here because you may want to use hash or array and have additional logic)
    # def reset_apps
    # end
    # def add_app
    # end
    # def remove_app
    # end
    # def get_apps
    # end
    # def has_app?
    # end
    # def execute
    # end
  end
end
