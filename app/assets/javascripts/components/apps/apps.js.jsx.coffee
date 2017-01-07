class @Apps extends React.Component
  constructor: (props) ->
    super props
    @state = {apps: []}

  componentDidMount: ->
    fetch('/api/1/apps').then((response) ->
      response.json()
    ).then((apps) =>
      @setState {apps: apps}
    )

  addApp: (app) =>
    app.highlight = true
    apps = Object.assign([], @state.apps)
    apps.unshift(app)
    @setState {apps: apps}

  removeApp: (appToRemove) =>
    apps = @state.apps.filter (app) -> app.id != appToRemove.id
    @setState {apps: apps}

  render: ->
    apps = @state.apps.map (app) =>
      React.createElement App, key: app.id, app: app, removeApp: @removeApp

    `<div className="container">
        <div id="apps">
            <AppForm addApp={this.addApp}/>
            {apps}
        </div>
    </div>`