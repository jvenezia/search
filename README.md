# Search

Sample app using [Algolia](https://www.algolia.com/) with `Rails` and `React.js` with [react-rails](https://github.com/reactjs/react-rails) gem.

Try it live: [search-production.herokuapp.com](http://search-production.herokuapp.com/).
Feel free to play with it, the database is reset every day.
 
## Getting started

1. Clone the repo.
    
        git clone git@github.com:jvenezia/search.git
        
2. Install dependencies.

        bundle install
        
3. Setup postgres database using your own config file.

        cp config/database.yml.example config/database.yml
        rake db:create db:migrate
        
4. Setup your algolia credentials and other variables in `.env` file. ALGOLIA_INDEX_NAME will be prepended with the current environment (eg: `search_production`).

        PORT=3000
        RAILS_ENV=development
        
        PUMA_WORKERS=1
        PUMA_WORKER_THREADS=1
        
        ALGOLIA_APPLICATION_ID=example
        ALGOLIA_API_KEY=example
        ALGOLIA_SEARCH_ONLY_API_KEY=example
        ALGOLIA_INDEX_NAME=search

5. Import dataset. This will also populate your Algolia index.

        rake reset_database

6. Run server with foreman.

        foreman start

You can run the test suit using `rake`.

## Contributing

Bug reports and pull requests are welcome on GitHub.

1. Fork it (https://github.com/jvenezia/search/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request