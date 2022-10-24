# frozen_string_literal: true

# Composite Design Pattern: https://refactoring.guru/design-patterns/composite
module Nuxt3genesisDirector
  # Parent allows upwards navigation to parent
  attr_reader :parent

  # XMEN: [{"name":"layout","name_plural":"layouts"}]
  # Layouts allow downwards navigation plus access to sub-layouts
  attr_reader :layouts

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
  # def reset_layouts
  # end
  # def add_layout
  # end
  # def remove_layout
  # end
  # def get_layouts
  # end
  # def has_layout?
  # end
  # def execute
  # end
end
