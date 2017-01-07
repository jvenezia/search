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
    @setState {app: @state.apps.unshift(app)}

  render: ->
    apps = @state.apps.map (app) =>
      React.createElement App, key: app.id, app: app

    `<div className="container">
        <div id="apps">
            <AppForm addApp={this.addApp}/>
            {apps}
        </div>
    </div>`