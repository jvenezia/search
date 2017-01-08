class @AppForm extends React.Component
  constructor: (props) ->
    super props
    @state = {isVisible: false, isLoading: false, app: new AppModel}

  resetApp: ->
    @setState app: new AppModel

  show: (event) =>
    event.preventDefault() if event
    @setState isVisible: true

  hide: (event) =>
    event.preventDefault() if event
    @setState isVisible: false

  inputChange: (event) =>
    app = {}
    app[event.target.name] = event.target.value
    @setState app: Object.assign(new AppModel, @state.app, app)

  submit: (event) =>
    event.preventDefault() if event
    @setState isLoading: true
    @state.app.save
      done: (app) =>
        @setState isLoading: false
        if app.hasErrors()
          @setState app: app
        else
          @resetApp()
          @hide()
          @props.addApp app

  render: ->
    if @state.isVisible
      if @state.isLoading
        submitText = 'Loading...'
      else
        submitText = 'Add'

      `<form id="app-form" onSubmit={this.submit}>
          <FormField onChange={this.inputChange} value={this.state.app.name || ''} errors={this.state.app.errors.name} required={true} name="name" placeholder="Name" type="text" autoFocus={true}/>
          <FormField onChange={this.inputChange} value={this.state.app.link || ''} errors={this.state.app.errors.link} required={true} name="link" placeholder="Link" type="text"/>
          <FormField onChange={this.inputChange} value={this.state.app.category || ''} errors={this.state.app.errors.category} required={true} name="category" placeholder="Category" type="text"/>
          <FormField onChange={this.inputChange} value={this.state.app.rank || ''} errors={this.state.app.errors.rank} required={true} name="rank" placeholder="Rank" type="text"/>
          <FormField onChange={this.inputChange} value={this.state.app.image || ''} errors={this.state.app.errors.image} name="image" placeholder="Image" type="text"/>
          <div className="actions">
              <button type="button" onClick={this.hide} className="btn btn-secondary">Cancel</button>
              <button type="submit" className="btn btn-primary">{submitText}</button>
          </div>
      </form>`
    else
      `<div id="app-form-button" onClick={this.show}>
          <i className="fa fa-plus"></i>
          Add an app </div>`