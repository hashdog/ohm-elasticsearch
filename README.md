# Ohm::Elasticsearch

Very small Ruby implementation for Elasticsearch (https://github.com/elasticsearch) and OHM (https://github.com/soveran/ohm).

## Installation

Add this line to your application's Gemfile:

    gem 'ohm-elasticsearch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ohm-elasticsearch

## Usage

    class Event < Ohm::Model
      include Ohm::Elasticsearch
      include Ohm::Callbacks #It's necessary for indexing records

      attribute :name
    end

    protected

    def after_save
      index_save
    end

    def before_delete
      index_delete
    end


    # Event.search({body: { query: { match: { name: 'test' } } } })

## Contributing

1. Fork it ( https://github.com/hashdog/ohm-elasticsearch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
