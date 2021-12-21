puts 'run'

KManager.action :run do
  def on_action

    director = HowtoDirector.init
      .h1('HTML Presentation' , 'Build HTML presentations')
      .h2('Web Slides'        , '[Web Slides](https://github.com/webslides/webslides) presentations framework')
      .h1('Ruby'              , 'Generate Ruby Code')
      .h2('Ruby Components'   , 'Ruby Code - Components')
      .h3('Command Line'      , 'Build command Line components that use dry-rb')
      .h3('Options Builder'   , 'Build OptionBuilders that help with flow control in complex code generation environments')
      # .logit

    builder
      .add_file('README.md',
                template_file: 'README.md',
                body: director.to_s,
                on_exist: :write)
  end
end
