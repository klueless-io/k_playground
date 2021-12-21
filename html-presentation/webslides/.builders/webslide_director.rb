class WebSlideDirector
  include KLog::Logging

  attr_reader :dom

  def initialize
    @dom = {
      direction: :vertical
    }
  end

  def title(value)
    dom[:title] = value

    self
  end

  def direction(value)
    dom[:direction] = value

    self
  end

  def logit
    log.structure(dom)

    self
  end

  def slides
  end

  def data
    KUtil.data.to_open_struct(@dom)
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
