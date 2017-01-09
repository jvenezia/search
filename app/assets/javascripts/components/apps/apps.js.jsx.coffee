class @Apps extends React.Component
  constructor: (props) ->
    super props
    @state = {apps: [], maxAppCount: 0, page: 1, query: '', isLoading: false, isLoadingNextApps: false, displayScrollTopButton: false}

  componentDidMount: ->
    @loadApps()
    window.addEventListener('scroll', this.handleScroll)

  handleScroll: =>
    scrollPosition = window.pageYOffset + window.innerHeight
    documentHeight = Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)

    if @state.apps.length < @state.maxAppCount && !@state.isLoadingNextApps && scrollPosition >= documentHeight - 1000
      @loadApps page: @state.page + 1, query: @state.query

    @setState displayScrollTopButton: scrollPosition > 2000

  scrollTop: =>
    smoothScroll.animateScroll(0)

  loadApps: (options = {}) =>
    @setState isLoadingNextApps: true, isLoading: true, page: (options.page || 1), query: (options.query || '')
    if @state.query
      AppModel.search @state.query, page: @state.page, done: @addApps
    else
      AppModel.all page: @state.page, done: @addApps

  addApps: (apps, maxAppCount) =>
    apps = @state.apps.concat(apps) if @state.page > 1
    @setState apps: apps, isLoadingNextApps: false, isLoading: false, maxAppCount: maxAppCount

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
            <AppSearch loadApps={this.loadApps} isLoading={this.state.isLoading}/>
            <AppForm addApp={this.addApp}/>
            {apps}
            {nextAppsLoader}
            {scrollTopButton}
        </div>
    </div>`