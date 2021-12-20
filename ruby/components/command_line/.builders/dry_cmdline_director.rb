class DryCmdlineDirector
  include KLog::Logging

  attr_reader :dom

  def initialize
    @dom = {
      namespaces: [],
      base_command_name: 'BaseCommand',
      base_command_type: 'Dry::CLI::Command'
    }
  end

  # @param [Array<String>] namespaces Full namespace for the command line classes
  def full_namespace(namespaces)
    dom[:full_namespace] = namespaces

    self
  end

  def base_command_name(value)
    dom[:base_command_name] = value

    self
  end

  def base_command_type(value)
    dom[:base_command_type] = value

    self
  end

  def logit
    log.structure(dom)

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
end

<<-RUBY

DryRbCommandLineDirector
  .init
  .root_namespace(%w[MacDiff CLI Commands])
  .base_command_name('BaseCommand') # .base_command_type('Dry::CLI::Command') (inferred)
  .commands do
    add(:version, description: 'Print version')
    add(:folders) do
      argument(:folder1, desc: 'Folder to compare against')
      argument(:folder2, desc: 'Folder to compare with')
    end
    add(:files) do
      argument(:file1, desc: 'File to compare against')
      argument(:file2, desc: 'File to compare with')
    end
  end

RUBY