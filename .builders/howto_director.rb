# frozen_string_literal: true

# Howto director will update README.md
class HowtoDirector
  include KLog::Logging

  attr_reader :lines

  def initialize
    @lines = []
  end

  # Heading level 1
  def h1(heading, description = nil)
    heading(heading, 1, description)

    self
  end

  # Heading level 2
  def h2(heading, description = nil)
    heading(heading, 2, description)

    self
  end

  # Heading level 3
  def h3(heading, description = nil)
    heading(heading, 3, description)

    self
  end

  def logit
    puts to_s

    self
  end

  def to_s
    lines.join("\n")
  end

  class << self
    def init
      new
    end
  end

  private

  def heading(heading, size, description)
    hashes = "#" * size
    add_line("#{hashes} #{heading}")

    if description
      add_line
      add_line(description)
      add_line
    end
  end 

  def add_line(line = nil)
    @lines << line
  end
end
