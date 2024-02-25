require 'faraday'

module Tibber
  # Deals with requests
  module Request

    # JSON-RPC is a stateless, light-weight remote procedure call (RPC) protocol. Primarily this
    # specification defines several data structures and the rules around their processing. It is
    # transport agnostic in that the concepts can be used within the same process, over sockets, over
    # http, or in many various message passing environments. It uses JSON (RFC 4627) as data format.
    #
    # https://www.jsonrpc.org/specification
    module GraphQL

      def graphql_call(query, params = nil)
        query = (query % params) if params && params.size > 0
        options = {
          "query": query
        }
        result = post( '', options )
        raise GraphQLError.new(result.body['errors']) if result.body['errors']
        data = result.body['data']
        WrAPI::Request::Entity.create(data['viewer'] ? data['viewer'] : data)

      rescue Faraday::BadRequestError => e
        body = e.response[:body]
        if body && body['errors']
          error = body['errors']
        else
          error = e.to_s
        end
        raise GraphQLError.new(error)
      end

    end
  end
end
