# frozen_string_literal: true

module MacDiff
module CLI
module Commands
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
end
end
end
      
      