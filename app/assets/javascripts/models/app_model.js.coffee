class window.AppModel
  constructor: (attributes = {}) ->
    @id = attributes.id
    @name = attributes.name
    @category = attributes.category
    @link = attributes.link
    @rank = attributes.rank
    @image = attributes.image
    @highlight = attributes.highlight
    @errors = attributes.errors ?= {}

  @all: (options = {}) ->
    url = '/api/1/apps'
    url += "?page=#{options.page}" if options.page
    fetch(url).then((response) => response.json()).then (appsJson) =>
      apps = appsJson.map (app) => new AppModel(app)
      options.done apps

  @search: (query, options = {}) ->
    algoliaIndex.search query, (error, content) =>
      apps = content.hits.map (hit) =>
        new AppModel Object.assign({}, hit, {name: hit._highlightResult.name.value, category: hit._highlightResult.category.value})
      options.done apps

  save: (options = {}) ->
    fetch('/api/1/apps',
      method: 'POST'
      headers: {'Accept': 'application/json', 'Content-Type': 'application/json'}
      body: JSON.stringify app: this
    ).then((response) =>
      response.json()
    ).then((appJson) =>
      this.errors = {} unless appJson.errors
      options.done Object.assign(new AppModel, this, appJson)
    )

  delete: (options = {}) ->
    fetch("/api/1/apps/#{this.id}", method: 'DELETE').then (appJson) =>
      options.done this

  hasErrors: ->
    Object.keys(@errors).length > 0