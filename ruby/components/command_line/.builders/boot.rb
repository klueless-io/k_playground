# Boot Sequence

include KLog::Logging

log.kv 'working folder', Dir.pwd

Handlebars::Helpers.configure do |config|
  config_file = File.join(Gem.loaded_specs['handlebars-helpers'].full_gem_path, '.handlebars_helpers.json')
  config.helper_config_file = config_file

  string_config_file = File.join(Gem.loaded_specs['handlebars-helpers'].full_gem_path, '.handlebars_string_formatters.json')
  config.string_formatter_config_file = string_config_file
end

def camel
  require 'handlebars/helpers/string_formatting/camel'
  Handlebars::Helpers::StringFormatting::Camel.new
end

def titleize
  require 'handlebars/helpers/string_formatting/titleize'
  Handlebars::Helpers::StringFormatting::Titleize.new
end

def pluralize
  require 'handlebars/helpers/inflection/pluralize'
  Handlebars::Helpers::Inflection::Pluralize.new
end

def singularize
  require 'handlebars/helpers/inflection/singularize'
  Handlebars::Helpers::Inflection::Singularize.new
end

KBuilder.configure(:cli) do |config|
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

KManager.fire_actions(:load_content, :register_document, :load_document)


