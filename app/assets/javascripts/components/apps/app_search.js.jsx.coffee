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
    `<div id="app-search">
        <input onChange={this.handleChange} placeholder="Search..." className="form-control" autoFocus/>
        <i className="fa fa-search"></i>
    </div>`