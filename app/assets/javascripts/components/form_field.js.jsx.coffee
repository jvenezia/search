class @FormField extends React.Component
  constructor: (props) ->
    super props

  render: ->
    errors = ''
    errors = `<div className="errors">{this.props.errors.join()}</div>` if @props.errors

    required = ''
    required = `<div className="required">Required</div>` if @props.required && !errors

    `<div className="form-field">
        <input value={this.props.value} onChange={this.props.onChange} name={this.props.name} type={this.props.type} placeholder={this.props.placeholder} autoFocus={this.props.autoFocus} className="form-control"/>
        {required}
        {errors}
    </div>`
