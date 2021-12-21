puts 'sean'
class OptionsBuilderDirector
  class << self
    def init
      new
    end
  end

  include KLog::Logging

  attr_reader :dom

  def initialize
    @dom = {
      option_groups: []
    }
  end

  def add_group(name, params: [], flags: [])
    group = {
      name: name,
      params: params,
      flags: flags
    }

    dom[:option_groups] << group

    self
  end

  def logit
    # log.structure(dom)
    puts JSON.pretty_generate(dom)

    self
  end

  def data
    KUtil.data.to_open_struct(@dom)
  end

  class << self
    def init
      new
    end
  end

  # builder.clipboard_copy(template: create_options_section_template, name: name, params: params, flags: flags)

  private

  # def option_go

end
