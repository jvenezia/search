class window.AppModel
  constructor: (attributes = {}) ->
    @id = attributes.id
    @name = attributes.name
    @category = attributes.category
    @link = attributes.link
    @rank = attributes.rank
    @image = attributes.image

  @all: (options = {}) ->
    url = '/api/1/apps'
    url += "?page=#{options.page}" if options.page
    fetch(url).then((response) => response.json()).then (appsJson) =>
      apps = appsJson.map (app) => new AppModel(app)
      options.done(apps)

  @search: (query, options = {}) ->
    algoliaIndex.search query, (error, content) =>
      apps = content.hits.map (hit) =>
        new AppModel Object.assign({}, hit, {name: hit._highlightResult.name.value, category: hit._highlightResult.category.value})
      options.done(apps)