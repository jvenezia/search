class @Apps extends React.Component
  constructor: (props) ->
    super props
    @state = {apps: [], maxAppCount: 0, page: 1, isLoading: false, isLoadingNextApps: false, displayScrollTopButton: false}

  componentDidMount: ->
    window.addEventListener('scroll', this.handleScroll)
    @loadApps()

  handleScroll: =>
    scrollPosition = window.pageYOffset + window.innerHeight
    documentHeight = Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)

    if @state.apps.length < @state.maxAppCount && !@state.isLoadingNextApps && scrollPosition >= documentHeight - 1000
      if @state.query
        @searchNextApps()
      else
        @loadNextApps()

    if scrollPosition > 2000
      @setState displayScrollTopButton: true
    else
      @setState displayScrollTopButton: false

  scrollTop: =>
    smoothScroll.animateScroll(0)

  loadApps: =>
    @setState isLoading: true, query: '', page: 1
    AppModel.all
      done: (apps, maxAppCount) =>
        @setState apps: apps, isLoading: false, maxAppCount: maxAppCount

  loadNextApps: =>
    @setState isLoadingNextApps: true, isLoading: true
    page = @state.page + 1
    AppModel.all
      page: page
      done: (apps, maxAppCount) =>
        @setState apps: @state.apps.concat(apps), isLoadingNextApps: false, isLoading: false, page: page, maxAppCount: maxAppCount

  searchApps: (query) =>
    @setState isLoading: true, query: query, page: 1
    AppModel.search query,
      done: (apps, maxAppCount) =>
        @setState apps: apps, isLoading: false, maxAppCount: maxAppCount

  searchNextApps: =>
    @setState isLoadingNextApps: true, isLoading: true
    page = @state.page + 1
    AppModel.search @state.query,
      page: page
      done: (apps, maxAppCount) =>
        @setState apps: @state.apps.concat(apps), isLoadingNextApps: false, isLoading: false, maxAppCount: maxAppCount, page: page

  addApp: (app) =>
    app.highlight = true
    apps = Object.assign([], @state.apps)
    apps.unshift(app)
    @setState apps: apps

  deleteApp: (appToDelete) =>
    apps = @state.apps.filter (app) -> app.id != appToDelete.id
    @setState apps: apps

  render: ->
    if @state.apps.length > 0
      apps = @state.apps.map (app) => React.createElement App, key: app.id, app: app, deleteApp: @deleteApp
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