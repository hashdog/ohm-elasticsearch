require "ohm/elasticsearch/version"
require 'elasticsearch'

module Ohm
  module Elasticsearch
    class ConnectException < IOError;end

    @@_current_indexer = nil

    def self.current_indexer
      @@_current_indexer or raise ConnectException, "Can't connect to ELasticsearch server"
    end

    def self.connect(arguments={})
      @@_current_indexer = ::Elasticsearch::Client.new(arguments)
    end

    def self.included(model)
      model.extend(ClassMethods)
      model.send(:include, InstanceMethods)
    end

    module ClassMethods
      def indexer
        Ohm::Elasticsearch.current_indexer
      end

      def index_name
        "#{name}_main".downcase
      end

      def index_type
        name.downcase
      end

      # args:
      # {body: { query: { match: { title: 'test' } } } }
      def search(args={})
        params = {index: index_name}.merge(args)
        indexer.search params
      end

      # args:
      #   {body: {
      #     template: {
      #       query: {
      #         range: {
      #          date: { gte: "{{start}}", lte: "{{end}}" }
      #             }
      #           }
      #         },
      #         params: { start: "2014-02-01", end: "2014-03-01" }
      #       }
      #    }
      def search_template(args={})
        template = {index: index_name}
        template.merge!(body: args)

        indexer.search_template template
      end
    end

    module InstanceMethods

      def index_attributes
        attributes
      end

      protected

      def index_save
        self.class.indexer.index(index: self.class.index_name, type: self.class.index_type, id: id, body: index_attributes)
      end

      def index_delete
        self.class.indexer.delete(index: self.class.index_name, type: self.class.index_type, id: id)
      end
    end
  end
end
