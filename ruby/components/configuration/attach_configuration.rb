# frozen_string_literal: true

# Usage: include Main::Sub::Configuration.new

module Main
module Sub
  # Configuration for Test Director
  attr_writer :configuration

  def configuration(name = :default)
    @configuration ||= Hash.new do |h, key|
      h[key] = Main::Sub::Configuration.new
    end
    @configuration[name]
  end

  def reset(name = :default)
    @configuration ||= Hash.new do |h, key|
      h[key] = Main::Sub::Configuration.new
    end
    @configuration[name] = Main::Sub::Configuration.new
  end

  def configure(name = :default)
    yield(configuration(name))
  end
end
end
