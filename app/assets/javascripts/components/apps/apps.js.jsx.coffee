class @Apps extends React.Component
  constructor: (props) ->
    super props
    algoliaIndex = algoliasearch(@props.algolia.applicationId, @props.algolia.apiKey).initIndex(@props.algolia.indexName)
    @state = {
      apps: [], page: 1, algoliaIndex: algoliaIndex,
      isLoading: false, isLoadingNextApps: false, displayScrollTopButton: false
    }

  componentDidMount: ->
    window.addEventListener('scroll', this.handleScroll)
    @loadApps()

  handleScroll: =>
    scrollPosition = window.pageYOffset + window.innerHeight
    documentHeight = Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)

    if !@state.query && !@state.isLoadingNextApps && scrollPosition >= documentHeight - 1000
      @loadNextApps()

    if scrollPosition > 2000
      @setState displayScrollTopButton: true
    else
      @setState displayScrollTopButton: false

  scrollTop: =>
    smoothScroll.animateScroll(0)

  loadApps: =>
    @setState isLoading: true, query: '', page: 1
    AppModel.all().then((apps) => @setState apps: apps, isLoading: false)

  loadNextApps: =>
    @setState isLoadingNextApps: true, isLoading: true
    page = @state.page + 1
    AppModel.all(page: page).then((apps) => @setState apps: @state.apps.concat(apps), isLoadingNextApps: false, isLoading: false, page: page)

  searchApps: (query) =>
    @setState isLoading: true, query: query
    @state.algoliaIndex.search query, (error, content) =>
      apps = content.hits.map (hit) =>
        Object.assign({}, hit, {name: hit._highlightResult.name.value, category: hit._highlightResult.category.value})
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

    scrollTopButton = `<div className="scroll-top-button" onClick={this.scrollTop}><i className="fa fa-arrow-up"></i>Top</div>` if @state.displayScrollTopButton

    `<div className="container">
        <div id="apps">
            <AppSearch searchApps={this.searchApps} loadApps={this.loadApps} isLoading={this.state.isLoading}/>
            <AppForm addApp={this.addApp}/>
            {apps}
            {nextAppsLoader}
            {scrollTopButton}
        </div>
    </div>`