puts 'run'

KManager.action :run_sean do
  def on_action

    director = WebSlideDirector.init
      .title('WebSlides: Making HTML presentations easy')
      .direction(:horizontal)
      # .slides do
      # end
      # .logit

    builder
      .add_file('index.html',
                template_file: 'webslide.html',
                dom: director.dom,
                on_exist: :write)
  end
end
