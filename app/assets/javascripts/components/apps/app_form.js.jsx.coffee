class @AppForm extends React.Component
  constructor: (props) ->
    super props
    @defaultApp = {name: '', link: '', image: '', category: '', rank: ''}
    @state = {isVisible: false, app: Object.assign({}, @defaultApp)}

  resetApp: ->
    @setState {app: Object.assign({}, @defaultApp)}

  show: (event) =>
    event.preventDefault() if event
    @setState {isVisible: true}

  hide: (event) =>
    event.preventDefault() if event
    @setState {isVisible: false}

  handleChange: (event) =>
    app = {}
    app[event.target.name] = event.target.value
    @setState {app: Object.assign({}, @state.app, app)}

  handleSubmit: (event) =>
    event.preventDefault()
    fetch('/api/1/apps',
      method: 'POST',
      headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
      body: JSON.stringify({app: @state.app})
    ).then((response) =>
      response.json()
    ).then((app) =>
      unless app.errors
        @props.addApp(app)
        @hide()
        @resetApp()
    )

  render: ->
    if @state.isVisible
      `<form id="app-form" onSubmit={this.handleSubmit}>
          <FormField onChange={this.handleChange} value={this.state.app.name} required={true} name="name" placeholder="Name" type="text" autoFocus={true}/>
          <FormField onChange={this.handleChange} value={this.state.app.link} required={true} name="link" placeholder="Link" type="text"/>
          <FormField onChange={this.handleChange} value={this.state.app.category} required={true} name="category" placeholder="Category" type="text"/>
          <FormField onChange={this.handleChange} value={this.state.app.rank} required={true} name="rank" placeholder="Rank" type="number"/>
          <FormField onChange={this.handleChange} value={this.state.app.image} name="image" placeholder="Image" type="text"/>
          <div className="actions">
              <button type="button" onClick={this.hide} className="btn btn-secondary">Cancel</button>
              <button type="submit" className="btn btn-primary">Add</button>
          </div>
      </form>`
    else
      `<div id="app-form">
          <div className="actions">
              <button type="button" onClick={this.show} className="btn btn-primary">Add an app</button>
          </div>
      </div>`