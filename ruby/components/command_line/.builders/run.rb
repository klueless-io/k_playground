# Run


KManager.model :david do
  settings do
    project_namespace 'Sample'
  end
end

# KBuilder.configuration(:cli).debug

def builder
  @builder ||= KBuilder::BaseBuilder.init(KBuilder.configuration(:cli))
end

builder.add_file('david')