class @Apps extends React.Component
  constructor: (props) ->
    @state = {apps: []}

  componentDidMount: ->
    fetch('/api/1/apps').then((response) ->
      response.json()
    ).then((json) =>
      @setState {apps: json}
    )

  render: ->
    apps = @state.apps.map (app) =>
      React.createElement App, key: app.id, app: app

    `<div id="apps">{apps}</div>`