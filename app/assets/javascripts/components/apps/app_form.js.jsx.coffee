class @AppForm extends React.Component
  constructor: (props) ->
    super props
    @defaultApp = {name: '', link: '', image: '', category: '', rank: ''}
    @state = {showForm: false, app: Object.assign({}, @defaultApp)}

  resetApp: ->
    @setState {app: Object.assign({}, @defaultApp)}

  showForm: =>
    @setState {showForm: true}

  hideForm: (event) =>
    event.preventDefault() if event
    @setState {showForm: false}

  handleChange: (event) =>
    newApp = {}
    newApp[event.target.name] = event.target.value
    @setState {app: Object.assign({}, @state.app, newApp)}

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
        @hideForm()
        @resetApp()
    )

  render: ->
    if @state.showForm
      `<form id="app-form" onSubmit={this.handleSubmit}>
          <input onChange={this.handleChange} name="name" value={this.state.app.name} type="text" placeholder="Name" className="form-control" autoFocus/>
          <input onChange={this.handleChange} name="link" value={this.state.app.link} type="text" placeholder="Link" className="form-control"/>
          <input onChange={this.handleChange} name="category" value={this.state.app.category} type="text" placeholder="Category" className="form-control"/>
          <input onChange={this.handleChange} name="rank" value={this.state.app.rank} type="number" placeholder="Rank" className="form-control"/>
          <input onChange={this.handleChange} name="image" value={this.state.app.image} type="text" placeholder="Image" className="form-control"/>
          <div className="actions">
              <button type="button" onClick={this.hideForm} className="btn btn-secondary">Cancel</button>
              <button type="submit" className="btn btn-primary">Add</button>
          </div>
      </form>`
    else
      `<div id="app-form">
          <div className="actions">
              <button type="button" onClick={this.showForm} className="btn btn-primary">Add an app</button>
          </div>
      </div>`