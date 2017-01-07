class @FormField extends React.Component
  constructor: (props) ->
    super props

  render: ->
    required = ''
    required = `<div className="required">Required</div>` if @props.required

    `<div className="form-field">
        <input value={this.props.value} onChange={this.props.onChange} name={this.props.name} type={this.props.type} placeholder={this.props.placeholder} autoFocus={this.props.autoFocus} className="form-control"/>
        {required}
    </div>`
