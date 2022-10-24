# frozen_string_literal: true

# BuilderOptions is an object that you configure and alter as needed for dynamic code generation
#
# # How to use
# build_options = BuilderOptions.init
#   .debug(1, a1: 1, b1: 1, c1: 1, aaa: 'Aaa', xxx: 'Xxx', abc: 'Abc', xyz: 'Xyz')
#   .more(1, the: 1, quick: 1, brown: 1, fox: 1, abc: 'Abc', xyz: 'Xyz', a1: 'A1', a2: 'A2', a3: 'A3')
# build_options.print # this will print debug information
#
# # Create an OpenStruct based on the configured build_options
# opts = build_options.build
class BuilderOptions
  class << self
    def init
      new
    end
  end

  def debug(active, a1: 0, b1: 0, c1: 0, aaa: '', xxx: '', abc: '', xyz: '')
    active = [true, 1].include?(active)

    # Flags
    a1 = active && [true, 1].include?(a1)
    b1 = active && [true, 1].include?(b1)
    c1 = active && [true, 1].include?(c1)

    @debug = {
      active: active,
      a1: a1,
      b1: b1,
      c1: c1,
      aaa: aaa,
      xxx: xxx,
      abc: abc,
      xyz: xyz
    }

    self
  end

  def debug!
    OpenStruct.new(@debug)
  end

  def more(active, the: 0, quick: 0, brown: 0, fox: 0, abc: '', xyz: '', a1: '', a2: '', a3: '')
    active = [true, 1].include?(active)

    # Flags
    the = active && [true, 1].include?(the)
    quick = active && [true, 1].include?(quick)
    brown = active && [true, 1].include?(brown)
    fox = active && [true, 1].include?(fox)

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

  def more!
    OpenStruct.new(@more)
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
