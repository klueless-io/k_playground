# frozen_string_literal: true

# Build Composite classes
# NOTE: Incomplete as I started going down the director pattern which is a version of the Composite Pattern
class CompositeDirector
  include KLog::Logging

  attr_reader :builder
  attr_reader :on_exist
  attr_reader :dom

  def initialize(builder, **opts)
    @builder = builder
    @on_exist = opts[:on_exist] || :skip # %i[skip write compare]
    @dom = {
      name: '',
      namespaces: [],
      children: [] # Cannot use children as it is a handlebars reserved word
    }
  end

  # Name or target name for the Composite, helps determine what it is used for
  def name(name)
    dom[:name] = name

    self
  end

  # @param [Array<String>] namespaces Full namespace for the command line classes
  def main_namespace(*namespaces)
    dom[:namespaces] = namespaces.to_a

    self
  end

  def add_child(name, name_plural)
    dom[:children] << { name: name, name_plural: name_plural }

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

  def default_opts
    {
      dom: dom,
      on_exist: on_exist
    }
  end

  def add_file(file, **opts)
    opts = default_opts.merge(opts)

    builder.add_file(file, **opts)
  end

  def build_composite(file = 'config.rb', **opts)
    base_opts = {
      cop: true,
      template_file: "ruby/design_patterns/composite/composite.rb"
    }
    opts = default_opts.merge(base_opts).merge(opts)

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
