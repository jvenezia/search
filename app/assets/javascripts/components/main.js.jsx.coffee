class @Main extends React.Component
  constructor: (props) ->
    super(props)

  render: ->
    `<Apps algolia={this.props.algolia}/>`