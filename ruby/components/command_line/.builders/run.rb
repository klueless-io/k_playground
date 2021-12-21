# Run

# KBuilder.configuration(:cli).debug

# KManager.model :david do
#   settings do
#     project_namespace 'Sample'
#   end
# end

def builder
  @builder ||= KBuilder::BaseBuilder.init(KBuilder.configuration(:cli))
end

# KManager.dashboard
# builder.debug
# builder.add_file('david')

KManager.action do
  def on_action
    puts '-' * 70
    director = DryCmdlineDirector
      .init
      .full_namespace(%w[MacDiff CLI Commands])
      .logit

    dom = director.dom
    data = director.data
      
    builder
      .add_file('data.json', content: JSON.pretty_generate(dom), on_exist: :write)

    # KBuilder.configuration(:cli).debug

    builder
      .add_file('base_command.rb',
                template_file: 'base_command.rb',
                on_exist: :write,
                rubo_cop: true,
                data: data)

    builder
      .add_file('commands.rb',
                template_file: 'commands.rb',
                on_exist: :write,
                data: data)
              puts '-' * 70
      # .namespace(%w[MacDiff CLI Commands])
    # .base_command_name('BaseCommand') # .base_command_type('Dry::CLI::Command') (inferred)
    # .commands do
    #   add(:version, description: 'Print version')
    #   add(:folders) do
    #     argument(:folder1, desc: 'Folder to compare against')
    #     argument(:folder2, desc: 'Folder to compare with')
    #   end
    #   add(:files) do
    #     argument(:file1, desc: 'File to compare against')
    #     argument(:file2, desc: 'File to compare with')
    #   end
    # end
  end
end
