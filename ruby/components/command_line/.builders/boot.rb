# Boot Sequence

include KLog::Logging

log.kv 'working folder', Dir.pwd

KConfig.configure do |config|
  config.handlebars.defaults.add_all_defaults
end

KConfig.configure(:cli) do |config|
  global_template = File.expand_path('~/dev/kgems/k_templates/templates')
  config.target_folders.add(:app, File.expand_path('../', Dir.pwd))
  config.template_folders.add(:global_template, global_template, '/ruby/components/command_line')
  config.template_folders.add(:app_template, File.expand_path('../.templates', Dir.pwd))
  # config.template_folders.add(:app , File.join(path, '.app_template'))
end

area = KManager.add_area(:cli)
resource_manager1 = area.resource_manager
resource_manager1.add_resource_expand_path('run.rb')
resource_manager1.add_resource_expand_path('dry_cmdline_director.rb')

KManager.boot


