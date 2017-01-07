class @AppSearch extends React.Component
  constructor: (props) ->
    super props
    @state = {}

  handleChange: (event) =>
    query = event.target.value
    if query == ''
      @props.loadApps()
    else
      @props.searchApps(event.target.value)

  render: ->
    if @props.loading
      icon = `<i className="fa fa-spinner fa-pulse"></i>`
    else
      icon = `<i className="fa fa-search"></i>`

    `<div id="app-search">
        <input onChange={this.handleChange} placeholder="Search..." className="form-control" autoFocus/>
        {icon}
    </div>`