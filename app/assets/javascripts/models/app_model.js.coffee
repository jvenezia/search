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
    maxAppCount = 0
    fetch(url).then((response) =>
      maxAppCount = response.headers.get('Total')
      response.json()
    ).then (appsJson) =>
      apps = appsJson.map (app) => new AppModel(app)
      options.done apps, maxAppCount

  @search: (query, options = {}) ->
    page = if options.page then options.page - 1 else 0
    algoliaIndex.search query, {page: page}, (error, content) =>
      maxAppCount = content.nbHits
      apps = content.hits.map (hit) =>
        new AppModel Object.assign({}, hit, {name: hit._highlightResult.name.value, category: hit._highlightResult.category.value})
      options.done apps, maxAppCount

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