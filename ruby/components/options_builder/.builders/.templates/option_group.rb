def {{name}}(active{{#each flags}}, {{.}}: 0{{/each}}{{#each params}}, {{.}}: ''{{/each}})
  active = active == true || active == 1

  {{#if flags}}
  # Flags
  {{#each flags}}
  {{.}} = active && ({{.}} == true || {{.}} == 1)
  {{/each}}
  {{/if}}

  @{{name}} = {
    active: active{{#each flags}},
    {{.}}: {{.}}{{/each}}{{#each params}},
    {{.}}: {{.}}{{/each}}
  }

  self
end
