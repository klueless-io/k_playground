# Boot Sequence

include KLog::Logging

KBuilder.configure(:cli) do |config|
  path = Dir.pwd
  global_template = File.expand_path('~/dev/kgems/k_templates/templates')
  log.kv 'working folder', path
  config.target_folders.add(:app, File.expand_path('../', path))
  config.template_folders.add(:command_line, global_template, '/ruby/components/command_line')
  # config.template_folders.add(:app , File.join(path, '.app_template'))
end

KBuilder.configuration(:cli).debug


area = KManager.add_area(:cli)
resource_manager1 = area.resource_manager
resource_manager1.add_resource_expand_path('run.rb')
