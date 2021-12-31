KManager.action :run do
  def on_action

    director = BuilderOptionsDirector.init
      .add_group(:debug, params: %i[aaa xxx abc xyz], flags: %i[a1 b1 c1])
      .add_group(:more, params: %i[abc xyz a1 a2 a3], flags: %i[the quick brown fox])
      # .logit

    builder
      .add_file('builder_options.rb',
                template_file: 'ruby/components/builder_options/builder_options.rb',
                dom: director.dom,
                on_exist: :write)
  end
end
