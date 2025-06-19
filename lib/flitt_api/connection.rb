module FlittAPI
  class Connection
    def initialize(api_url:)
      @conn = Faraday.new(url: api_url) do |faraday|
        faraday.request :json
        faraday.response :json
        faraday.response :logger, nil, { headers: true, bodies: true, errors: true }
      end
    end

    def get(path)
      response = conn.get(path)
      handle_response(response)
    end
    
    def post(path, body)
      response = conn.post(path, { request: body })
      handle_response(response)
    end
    
    private

    attr_reader :conn

    def handle_response(response)
      if response.success? && response.body["response"]["response_status"] == "success"
        response.body["response"]
      else
        raise Error.new(response.body["response"]["error_message"] || 'Unknown error', response.status)
      end
    end

    class Error < StandardError
      attr_reader :status_code

      def initialize(message, status_code)
        super(message)
        @status_code = status_code
      end
    end
  end
end