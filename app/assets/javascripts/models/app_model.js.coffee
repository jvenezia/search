class window.AppModel
  @all: (options = {}) ->
    url = '/api/1/apps'
    url += "?page=#{options.page}" if options.page
    fetch(url).then((response) => response.json())