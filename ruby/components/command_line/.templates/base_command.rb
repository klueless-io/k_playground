# frozen_string_literal: true

{{#each data.full_namespace}}module {{.}}
{{/each}}
    include KLog::Logging

    option    :log_level,
              default: 'none',
              aliases: ['-l'],
              desc: 'Log level (:none, :debug)'

    private

    def absolute_path(path, base_path)
      pathname = Pathname.new(path)
      pathname.absolute? ? path : File.expand_path(path, base_path)
    end
{{#each data.full_namespace}}end
{{/each}}
      
      