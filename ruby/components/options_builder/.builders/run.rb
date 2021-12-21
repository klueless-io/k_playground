puts 'run'

KManager.action :run do
  def on_action

    director = OptionsBuilderDirector.init
      .add_group(:debug, params: %i[xxx abc xyz], flags: %i[a1 b1 c1])
      .add_group(:more, params: %i[abc xyz a1 a2 a3], flags: %i[the quick brown fox])
      .logit

    builder
      .add_file('options_builder.rb',
                template_file: 'options_builder.rb',
                dom: director.dom,
                on_exist: :write)
  end
end
