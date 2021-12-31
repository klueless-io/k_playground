# Run
KManager.action do
  def on_action
    puts '-' * 70
    director = ConfigurationDirector
      .init(builder, on_exist: :write)
      .style(:named)
      .name('Test Director')
      .main_namespace('Main', 'Sub')
      .add_config_key(:some_key, "''")
      .add_config_key(:some_other_key, "'xmen'")
      # .logit

    # director.sample
    # dom = director.dom
    # data = director.data

    director.add_attach_configuration
    director.add_configuration
  end
end

KManager.opts.app_name                    = 'Configuration Class Generator'
KManager.opts.sleep                       = 5
KManager.opts.reboot_on_kill              = 0
KManager.opts.reboot_sleep                = 4
KManager.opts.exception_style             = :short
KManager.opts.show.time_taken             = true
KManager.opts.show.finished               = true
KManager.opts.show.finished_message       = 'FINISHED :)'

