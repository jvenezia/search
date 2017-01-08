class @App extends React.Component
  constructor: (props) ->
    super props
    @defaultImageUrl = '/default_app_icon.png'
    @state = {app: props.app}

  remove: (event) =>
    event.preventDefault() if event
    if confirm("Remove #{@state.app.name}?")
      fetch("/api/1/apps/#{@state.app.id}",
        method: 'DELETE'
      ).then((app) =>
        @props.removeApp(@state.app)
      )

  setDefaultImage: (event) =>
    event.target.src = @defaultImageUrl

  render: ->
    console.log @state.app.image
    if @state.app.image
      imageUrl = @state.app.image
    else
      imageUrl = @defaultImageUrl

    className = 'app'
    className = className.concat(' highlight') if @state.app.highlight
    `<div className="app-wrapper">
        <a className={className} href={this.state.app.link} target="_blank">
            <div className="name">{this.state.app.name}</div>
            <div className="category">{this.state.app.category}</div>
            <img src={imageUrl} onError={this.setDefaultImage}/>
        </a>
        <div className='actions'>
            <a className="remove" onClick={this.remove}>
                <i className="fa fa-remove"></i>
                Remove
            </a>
        </div>
    </div>
    `
