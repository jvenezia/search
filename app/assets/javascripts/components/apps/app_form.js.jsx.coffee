class @AppForm extends React.Component
  constructor: (props) ->
    super props
    @defaultApp = {name: '', link: '', image: '', category: '', rank: '', errors: {}}
    @state = {isVisible: false, isLoading: false, app: Object.assign({}, @defaultApp)}

  resetApp: ->
    @setState {app: Object.assign({}, @defaultApp)}

  show: (event) =>
    event.preventDefault() if event
    @setState {isVisible: true}

  hide: (event) =>
    event.preventDefault() if event
    @setState {isVisible: false}

  inputChange: (event) =>
    app = {}
    app[event.target.name] = event.target.value
    @setState {app: Object.assign({}, @state.app, app)}

  submit: (event) =>
    event.preventDefault() if event
    @setState {isLoading: true}
    fetch('/api/1/apps',
      method: 'POST',
      headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
      body: JSON.stringify({app: @state.app})
    ).then((response) =>
      response.json()
    ).then((app) =>
      if app.errors
        @setState {app: Object.assign({}, @state.app, {errors: app.errors})}
      else
        @props.addApp(app)
        @hide()
        @resetApp()
      @setState {isLoading: false}
    )

  render: ->
    if @state.isVisible
      if @state.isLoading
        submitText = 'Loading...'
      else
        submitText = 'Add'

      `<form id="app-form" onSubmit={this.submit}>
          <FormField onChange={this.inputChange} value={this.state.app.name} errors={this.state.app.errors.name} required={true} name="name" placeholder="Name" type="text" autoFocus={true}/>
          <FormField onChange={this.inputChange} value={this.state.app.link} errors={this.state.app.errors.link} required={true} name="link" placeholder="Link" type="text"/>
          <FormField onChange={this.inputChange} value={this.state.app.category} errors={this.state.app.errors.category} required={true} name="category" placeholder="Category" type="text"/>
          <FormField onChange={this.inputChange} value={this.state.app.rank} errors={this.state.app.errors.rank} required={true} name="rank" placeholder="Rank" type="text"/>
          <FormField onChange={this.inputChange} value={this.state.app.image} errors={this.state.app.errors.image} name="image" placeholder="Image" type="text"/>
          <div className="actions">
              <button type="button" onClick={this.hide} className="btn btn-secondary">Cancel</button>
              <button type="submit" className="btn btn-primary">{submitText}</button>
          </div>
      </form>`
    else
      `<div id="app-form-button" onClick={this.show}>
          <i className="fa fa-plus"></i>
          Add an app
      </div>`