puts 'run'

KManager.action :run do
  def on_action

    director = HowtoDirector.init
      .h1('HTML Presentation'   , 'Build HTML presentations')
      .h2('Web Slides'          , '[Web Slides](https://github.com/webslides/webslides) presentations framework')
      .h1('Ruby'                , 'Generate Ruby Code')
      .h2('Ruby Components'     , 'Ruby Code - Components')
      .h3('Command Line'        , 'Build command Line components that use dry-rb')
      .h3('Builder Options'     , 'Build BuilderOptions that provide flow control in complex code generation environments')
      .h2('Ruby Design Pattern' , 'Build design patterns using Ruby')
      .h3('Composite'           , 'Composite is a structural design pattern that lets you compose objects into tree structures and then work with these structures as if they were individual objects.')
      # .logit

    builder
      .add_file('README.md',
                template_file: 'README.md',
                body: director.to_s,
                on_exist: :write)
  end
end
