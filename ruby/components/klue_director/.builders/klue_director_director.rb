# frozen_string_literal: true

# Build a Klue Director
class KlueDirectorDirector
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
      child_directors: [],
      builder_nodes: []
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

  def builder_node(name, actions = [])
    dom[:builder_nodes] << { name: name, actions: actions }

    self
  end

  def child_director(name, name_plural)
    dom[:child_directors] << { name: name, name_plural: name_plural }

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

  def build_director(file = nil, **opts)
    file = "#{@dom[:name]}_director.rb" unless file

    base_opts = {
      cop: true,
      template_file: "ruby/components/klue_director/director.rb"
    }
    opts = default_opts.merge(base_opts).merge(opts)

    builder.add_file(file, **opts)
    file = "/Users/davidcruwys/dev/printspeak/documentation/architecture/.builders/directors/#{@dom[:name]}_director.rb"
    builder.add_file(file, **opts)

    self
  end

  def build_builder(file = nil, **opts)
    file = "#{@dom[:name]}_builder.rb" unless file

    base_opts = {
      cop: true,
      template_file: "ruby/components/klue_director/builder.rb"
    }
    opts = default_opts.merge(base_opts).merge(opts)

    builder.add_file(file, **opts)
    file = "/Users/davidcruwys/dev/printspeak/documentation/architecture/.builders/directors/#{@dom[:name]}_builder.rb"
    builder.add_file(file, **opts)

    self
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
