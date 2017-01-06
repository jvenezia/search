class @App extends React.Component
  constructor: (props) ->
    @app = props.app

  render: ->
    `<div className="app">
        <div>{this.app.name}</div>
        <img src={this.app.image}/>
    </div>`
