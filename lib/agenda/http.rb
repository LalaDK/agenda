module Agenda
  class Http
    require 'uri'
    require 'net/http'

    def self.fetch(url:)
      uri = URI(url)
      response = Net::HTTP.get_response(uri)
      response.body
    end
  end
end
