json.partial! 'app', app: @app

json.errors @app.errors.messages unless @app.errors.messages.empty?