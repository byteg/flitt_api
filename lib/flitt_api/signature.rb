module FlittAPI
  class Signature
    def initialize(secret_key:, params:)
      @secret_key = secret_key
      @params = params
    end

    def call
      Digest::SHA1.hexdigest(generate_signature_string)
    end

    private

    def generate_signature_string
      sorted_params = @params.except('signature', :signature).keys.sort.map { |key| @params[key].to_s }.filter { |value| value != nil && value != '' }.join('|')
      "#{@secret_key}|#{sorted_params}"
    end
  end
end
