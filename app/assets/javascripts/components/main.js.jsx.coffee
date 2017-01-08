class @Main extends React.Component
  constructor: (props) ->
    super(props)
    window.algoliaIndex = algoliasearch(@props.algolia.applicationId, @props.algolia.apiKey).initIndex(@props.algolia.indexName)

  render: ->
    `<Apps/>`