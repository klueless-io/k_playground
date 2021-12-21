class BuilderOptions
  class << self
    def init
      new
    end
  end

  {{option_groups}}

  def printer!
    OpenStruct.new(@printer)
  end

  def build
    data = {
      debug: @debug,
      filter: @filter,
      db_schema: @db_schema,
      domain_model: @domain_model,
      sql_count: @sql_count,
      rubocop: @rubocop,
      data_context: @data_context,
      printer: @printer
    }
    KUtil.data.to_open_struct(data)
  end

  def print
    log.section_heading 'debug options'

    # log.open_struct(build)
    log.structure(build) # , graph: { filter: { names: { skip_empty: true } } })
  end
end
