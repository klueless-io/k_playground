# frozen_string_literal: true

# Build Configuration classes
class ConfigurationDirector
  include KLog::Logging

  attr_reader :builder
  attr_reader :dom

  def initialize(builder)
    @builder = builder
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

  def add_attach_configuration(file = 'attach_configuration.rb', **opts)
    opts = opts.merge(
      dom: dom,
      on_exist: :write,
      template_file: "ruby/components/configuration/attach_#{dom[:style]}_configuration.rb")

    builder.add_file(file, opts)
  end

  def add_configuration(file = 'configuration.rb', **opts)
    opts = opts.merge(
      dom: dom,
      on_exist: :write,
      template_file: "ruby/components/configuration/configuration.rb")

    builder.add_file(file, opts)
  end

  class << self
    def init(builder)
      new(builder)
    end
  end

  private

  def dirty?
    @dirty
  end
end