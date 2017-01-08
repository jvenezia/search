class @Apps extends React.Component
  constructor: (props) ->
    super props
    algoliaIndex = algoliasearch(@props.algolia.applicationId, @props.algolia.apiKey).initIndex(@props.algolia.indexName)
    @state = {apps: [], page: 1, isLoading: false, isLoadingNextApps: false, algoliaIndex: algoliaIndex}

  componentDidMount: ->
    window.addEventListener('scroll', this.handleScroll)
    @loadApps()

  handleScroll: =>
    scrollPosition = window.pageYOffset + window.innerHeight
    documentHeight = Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)

    if !@state.query && !@state.isLoadingNextApps && scrollPosition >= documentHeight - 1000
      @loadNextApps @state.page + 1

  loadApps: =>
    @setState isLoading: true, query: '', page: 1
    fetch('/api/1/apps').then((response) =>
      response.json()
    ).then((apps) =>
      @setState apps: apps, isLoading: false
    )

  loadNextApps: (page) =>
    @setState isLoadingNextApps: true, isLoading: true
    fetch("/api/1/apps?page=#{page}").then((response) =>
      response.json()
    ).then((apps) =>
      @setState apps: @state.apps.concat(apps), isLoadingNextApps: false, isLoading: false, page: @state.page + 1
    )

  searchApps: (query) =>
    @setState isLoading: true, query: query
    @state.algoliaIndex.search query, (error, content) =>
      apps = content.hits.map (hit) =>
        Object.assign({}, hit, {name: hit._highlightResult.name.value, category: hit._highlightResult.category.value})
      console.log content.hits[0]
      @setState apps: apps, isLoading: false

  addApp: (app) =>
    app.highlight = true
    apps = Object.assign([], @state.apps)
    apps.unshift(app)
    @setState apps: apps

  removeApp: (appToRemove) =>
    apps = @state.apps.filter (app) -> app.id != appToRemove.id
    @setState apps: apps

  render: ->
    if @state.apps.length > 0
      apps = @state.apps.map (app) =>
        React.createElement App, key: app.id, app: app, removeApp: @removeApp
    else if @state.query
      apps = `<div className="empty">No apps matches your search.</div>`

    nextAppsLoader = `<div className="next-apps-loader"><i className="fa fa-spinner fa-pulse"></i></div>` unless @state.query

    `<div className="container">
        <div id="apps">
            <AppSearch searchApps={this.searchApps} loadApps={this.loadApps} isLoading={this.state.isLoading}/>
            <AppForm addApp={this.addApp}/>
            {apps}
            {nextAppsLoader}
        </div>
    </div>`