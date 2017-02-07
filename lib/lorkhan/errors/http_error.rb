module Lorkhan
  module Errors
    class HTTPError < Base
      attr_reader :status

      def initialize(response)
        super("http_error/#{response.status}")
        @status = response.status
      end
    end
  end
end
