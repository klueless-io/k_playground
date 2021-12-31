# frozen_string_literal: true

# Usage: include Main::Sub::Configuration.new

module Main
module Sub
  # Configuration object for all k_builder* GEM
  class Configuration
    include KLog::Logging

    attr_accessor :some_key
    attr_accessor :some_other_key

    def initialize
      @some_key = ''
      @some_other_key = 'xmen'
    end

    def debug(heading: 'Test director configuration')
      log.section_heading heading if heading
    
      log.kv 'some_key', some_key
      log.kv 'some_other_key', some_other_key
      ''
    end

    def to_h
      {
        some_key: some_key,
        some_other_key: some_other_key
      }
    end
  end
end
end
end
