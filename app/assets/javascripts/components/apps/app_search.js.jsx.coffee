class @AppSearch extends React.Component
  constructor: (props) ->
    super props
    @state = {changeTimeout: null}

  handleChange: (event) =>
    event.persist()
    changeTimeout = setTimeout =>
      query = event.target.value
      if query == ''
        @props.loadApps()
      else
        @props.searchApps(event.target.value)
    , 300
    clearTimeout @state.changeTimeout
    @setState changeTimeout: changeTimeout

  render: ->
    if @props.isLoading
      icon = `<i className="fa fa-spinner fa-pulse"></i>`
    else
      icon = `<i className="fa fa-search"></i>`

    `<div id="app-search">
        <input onChange={this.handleChange} placeholder="Search..." className="form-control" type="text" autoFocus/>
        {icon}
    </div>`