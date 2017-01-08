class @App extends React.Component
  constructor: (props) ->
    super props
    @defaultImageUrl = '/default_app_icon.png'

  removeApp: (event) =>
    event.preventDefault() if event
    if confirm("Remove #{@props.app.name}?")
      fetch("/api/1/apps/#{@props.app.id}",
        method: 'DELETE'
      ).then((app) =>
        @props.removeApp(@props.app)
      )

  setDefaultImage: (event) =>
    event.target.src = @defaultImageUrl

  render: ->
    if @props.app.image
      imageUrl = @props.app.image
    else
      imageUrl = @defaultImageUrl

    className = 'app'
    className = className.concat(' highlight') if @props.app.highlight
    `<div className="app-wrapper">
        <a className={className} href={this.props.app.link} target="_blank">
            <div className="name" dangerouslySetInnerHTML={{__html: this.props.app.name}}></div>
            <div className="category" dangerouslySetInnerHTML={{__html: this.props.app.category}}></div>
            <img src={imageUrl} onError={this.setDefaultImage}/>
        </a>
        <div className='actions'>
            <a className="remove" onClick={this.removeApp}>
                <i className="fa fa-remove"></i>
                Remove
            </a>
        </div>
    </div>
    `
