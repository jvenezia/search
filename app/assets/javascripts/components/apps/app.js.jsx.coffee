class @App extends React.Component
  constructor: (props) ->
    super props
    @state = {app: props.app}

  remove: (event) =>
    event.preventDefault() if event
    if confirm('Remove app?')
      fetch("/api/1/apps/#{@state.app.id}",
        method: 'DELETE'
      ).then((app) =>
        @props.removeApp(@state.app)
      )

  removeDeadImage: (event) =>
    event.target.src = ''

  render: ->
    className = 'app'
    className = className.concat(' highlight') if @state.app.highlight
    `<div className="app-wrapper">
        <a className={className} href={this.state.app.link} target="_blank">
            <div className="name">{this.state.app.name}</div>
            <div className="category">{this.state.app.category}</div>
            <img src={this.state.app.image} onError={this.removeDeadImage}/>
        </a>
        <div className='actions'>
            <a className="remove" onClick={this.remove}>Remove</a>
        </div>
    </div>
    `
