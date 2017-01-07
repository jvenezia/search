class @Apps extends React.Component
  constructor: (props) ->
    super props
    algoliaIndex = algoliasearch(@props.algolia.applicationId, @props.algolia.apiKey).initIndex(@props.algolia.indexName)
    @state = {apps: [], isLoading: false, algoliaIndex: algoliaIndex}

  componentDidMount: ->
    @loadApps()

  loadApps: =>
    @setState isLoading: true
    fetch('/api/1/apps').then((response) ->
      response.json()
    ).then((apps) =>
      @setState apps: apps, isLoading: false
    )

  searchApps: (query) =>
    @setState isLoading: true
    @state.algoliaIndex.search query, (error, content) =>
      apps = content.hits
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
    apps = @state.apps.map (app) =>
      React.createElement App, key: app.id, app: app, removeApp: @removeApp

    `<div className="container">
        <div id="apps">
            <AppSearch searchApps={this.searchApps} loadApps={this.loadApps} isLoading={this.state.isLoading}/>
            <AppForm addApp={this.addApp}/>
            {apps}
        </div>
    </div>`