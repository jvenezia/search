class @App extends React.Component
  constructor: (props) ->
    super props
    @state = {app: props.app}

  removeDeadImage: (event) =>
    event.target.src = ''

  render: ->
    `<a className="app" href={this.state.app.link} target="_blank">
        <div className="name">{this.state.app.name}</div>
        <div className="category">{this.state.app.category}</div>
        <img src={this.state.app.image} onError={this.removeDeadImage}/>
    </a>`
