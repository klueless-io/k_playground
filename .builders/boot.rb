# Boot Sequence

include KLog::Logging

log.kv 'working folder', Dir.pwd

Handlebars::Helpers.configure do |config|
  config_file = File.join(Gem.loaded_specs['handlebars-helpers'].full_gem_path, '.handlebars_helpers.json')
  config.helper_config_file = config_file

  string_config_file = File.join(Gem.loaded_specs['handlebars-helpers'].full_gem_path, '.handlebars_string_formatters.json')
  config.string_formatter_config_file = string_config_file
end

KBuilder.configure do |config|
  global_template = File.expand_path('~/dev/kgems/k_templates/templates')
  config.target_folders.add(:app, File.expand_path('../', Dir.pwd))
  config.template_folders.add(:global_template, global_template)
  config.template_folders.add(:app_template, File.expand_path('.templates', Dir.pwd))
end
# KBuilder.configuration.debug

area = KManager.add_area(:documentation)
resource_manager = area.resource_manager
resource_manager.add_resource_expand_path('run.rb')
resource_manager.add_resource_expand_path('dry_cmdline_director.rb')

KManager.fire_actions(:load_content, :register_document, :load_document)


