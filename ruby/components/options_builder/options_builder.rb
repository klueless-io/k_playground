class BuilderOptions
  class << self
    def init
      new
    end
  end
  
  def debug(active, a1: 0, b1: 0, c1: 0, xxx: '', abc: '', xyz: '')
    active = active == true || active == 1
  
    # Flags
    a1 = active && (a1 == true || a1 == 1)
    b1 = active && (b1 == true || b1 == 1)
    c1 = active && (c1 == true || c1 == 1)
  
    @debug = {
      active: active,
      a1: a1,
      b1: b1,
      c1: c1,
      xxx: xxx,
      abc: abc,
      xyz: xyz
    }
  
    self
  end
  
  def more(active, the: 0, quick: 0, brown: 0, fox: 0, abc: '', xyz: '', a1: '', a2: '', a3: '')
    active = active == true || active == 1
  
    # Flags
    the = active && (the == true || the == 1)
    quick = active && (quick == true || quick == 1)
    brown = active && (brown == true || brown == 1)
    fox = active && (fox == true || fox == 1)
  
    @more = {
      active: active,
      the: the,
      quick: quick,
      brown: brown,
      fox: fox,
      abc: abc,
      xyz: xyz,
      a1: a1,
      a2: a2,
      a3: a3
    }
  
    self
  end

  def printer!
    OpenStruct.new(@printer)
  end

  def build
    data = {
      debug: @debug,
      more: @more
    }
    KUtil.data.to_open_struct(data)
  end

  def print
    log.section_heading 'debug options'

    # log.open_struct(build)
    log.structure(build) # , graph: { filter: { names: { skip_empty: true } } })
  end
end
