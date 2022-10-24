# Run
KManager.action do
  def on_action
    # NOTE: Incomplete as I started going down the director pattern which is a version of the Composite Pattern
    puts '-' * 70
    director = CompositeDirector
      .init(builder, on_exist: :write)
      .name('Nuxt3_Composite')
      .main_namespace()
      .add_child('layout', 'layouts')
      .logit

    puts JSON.pretty_generate(director.dom)
    director.build_composite
    # director.sample
    # dom = director.dom
    # data = director.data
  end
end

KManager.opts.app_name                    = 'Composite Class Generator'
KManager.opts.sleep                       = 0
KManager.opts.reboot_on_kill              = 0
KManager.opts.reboot_sleep                = 4
KManager.opts.exception_style             = :short
KManager.opts.show.time_taken             = true
KManager.opts.show.finished               = true
KManager.opts.show.finished_message       = 'FINISHED :)'

