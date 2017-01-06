class @App extends React.Component
  constructor: (props) ->
    @app = props.app

  removeDeadImage: (event) ->
    event.target.src = ''

  render: ->
    `<a className="app" href={this.app.link} target="_blank">
        <div className="name">{this.app.name}</div>
        <div className="category">{this.app.category}</div>
        <img src={this.app.image} onError={this.removeDeadImage}/>
    </a>`
