module Lorkhan
  module Errors
    class HTTPError < Base
      attr_reader :status, :response

      def initialize(response)
        super("http_error/#{response.status}")
        @response = response
        @status = response.status
      end
    end
  end
end
