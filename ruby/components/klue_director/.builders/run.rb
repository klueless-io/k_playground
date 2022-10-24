# Run
KManager.action do
  def on_action
    director = KlueDirectorDirector
      .init(builder, on_exist: :write)
      .name(:nuxt3_genesis)
      .main_namespace('directors')
      .builder_node(:app, [:add])
      .child_director('app', 'apps')
      # .add_child_list('app', 'apps')
      # .add_child_leaf('app')
      .logit

    puts JSON.pretty_generate(director.dom)
    director
      .build_builder
      .build_director
    # director.sample
    # dom = director.dom
    # data = director.data
  end
end

KManager.opts.app_name                    = 'Composite Class Generator'
KManager.opts.sleep                       = 3
KManager.opts.reboot_on_kill              = 0
KManager.opts.reboot_sleep                = 4
KManager.opts.exception_style             = :short
KManager.opts.show.time_taken             = true
KManager.opts.show.finished               = true
KManager.opts.show.finished_message       = 'FINISHED :)'

# .app(:app, style: :nuxt_page) do
#   add('app.vue', 'app_simple_page.vue')
#   add('nuxt.config.ts', 'nuxt.config.ts')
#   add('tailwind.config.js', 'tailwind.config.js')
#   add('assets/css/styles.css', 'assets/styles/tailwind_styles.css')
# end
