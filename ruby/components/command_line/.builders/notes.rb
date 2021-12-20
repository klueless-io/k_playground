

# Commands (Module with registries)
# Base Command
# Version Command
# Other Commands

KManager.model do
  settings do
    namespace         %w[MacDiff CLI Commands]
    base_command_name 'BaseCommand'
    base_command_type 'Dry::CLI::Command'
  end

  tables :commands do
    row :version
    row :folders
    row :files
  end
end

# Goal create command line classes [commands, base_command, version, folders, files]
# Steps
#   - New Director called DryRbCommandLineDirector
#   - Directory needs to produce JSON (OpenStruct)
#   - Build Templates for (commands, base_command, command)
#   - Builder that writes commands
#   - Builder that writes base_command
#   - Builder that writes array of command

DryRbCommandLineDirector
  .init
  .namespace(%w[MacDiff CLI Commands])
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


module MacDiff
  module CLI
    module Commands
    end
  end
end