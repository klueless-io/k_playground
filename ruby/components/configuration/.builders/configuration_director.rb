# frozen_string_literal: true

# Build Configuration classes
class ConfigurationDirector
  include KLog::Logging

  attr_reader :builder
  attr_reader :dom
  attr_reader :on_exist

  def initialize(builder, on_exist: :write)
    @builder = builder
    @on_exist = on_exist
    @dom = {
      name: '',
      style: :simple,
      namespaces: [],
      config_keys: []
    }
  end

  # Name or target name for the configuration, helps determine what it is used for
  def name(name)
    dom[:name] = name

    self
  end

  def add_config_key(name, default_value)
    config_key = {
      name: name,
      default_value: default_value
    }

    dom[:config_keys] << config_key

    self
  end

  # @param [Array<String>] namespaces Full namespace for the command line classes
  def main_namespace(*namespaces)
    dom[:namespaces] = namespaces.to_a

    self
  end
  
  # @param [Symbol] style Configuration style. :simple, :named, :plugin (not sure if plugin is a style)
  #   style:  :simple - single configuration instance for the the GEM
  #           :named  - named configuration instances for the the GEM
  def style(style)
    dom[:style] = style

    self
  end

  def logit
    log.structure(dom)

    self
  end

  def data
    # @data = KUtil.data.to_open_struct(@dom) if dirty?
    # @dirty = false
    # @data
    KUtil.data.to_open_struct(@dom)
  end

  def add_file(file, **opts)
    builder.add_file(file, **opts.merge(dom: dom, on_exist: :write))
  end

  def add_config(file = 'config.rb', **opts)
    opts = opts.merge(
      dom: dom,
      cop: true,
      on_exist: on_exist,
      template_file: "ruby/components/configuration/#{dom[:style]}_configuration.rb")

    builder.add_file(file, **opts)
  end

  def add_configuration(file = 'configuration.rb', **opts)
    opts = opts.merge(
      dom: dom,
      cop: true,
      on_exist: on_exist,
      template_file: "ruby/components/configuration/configuration.rb")

    builder.add_file(file, **opts)
  end

  def sample
    log.subheading('SAMPLE')
    puts sample_action
    log.line

    self
  end

  class << self
    def init(builder, **opts)
      new(builder, **opts)
    end
  end

  private

  def dirty?
    @dirty
  end

  def sample_action
    <<-RUBY
KManager.action do
  def on_action
    puts '-' * 70
    director = ConfigurationDirector
      .init(builder)
      .style(:named)
      .name('Test Director')
      .main_namespace('Main', 'Sub')
      .add_config_key(:some_key, "''")
      .add_config_key(:some_other_key, "'xmen'")
      .logit

    director.sample

    director.add_config
    director.add_configuration
  end
end
        RUBY
  end

end
