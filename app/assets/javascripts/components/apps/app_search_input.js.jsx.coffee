class @AppSearchInput extends React.Component
  constructor: (props) ->
    super props
    @state = {changeTimeout: null, value: ''}

  handleChange: (event) =>
    event.persist()
    value = event.target.value
    changeTimeout = setTimeout =>
      if value
        @props.loadApps query: value
      else
        @props.loadApps()
    , 200
    clearTimeout @state.changeTimeout
    @setState changeTimeout: changeTimeout, value: value

  clearInput: (event) =>
    @setState value: ''
    @props.loadApps()

  render: ->
    if @props.isLoading
      icon = `<i className="fa fa-spinner fa-pulse"></i>`
    else if @state.value
      icon = `<div className="clear-input-button" onClick={this.clearInput}><i className="fa fa-remove"></i></div>`
    else
      icon = `<i className="fa fa-search"></i>`

    `<div id="app-search">
        <input onChange={this.handleChange} value={this.state.value} placeholder="Search..." className="form-control" type="text" autoFocus/>
        {icon}
    </div>`