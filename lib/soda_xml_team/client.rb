module SodaXmlTeam

  require 'httparty'
  require 'nokogiri'
  
  class Client
    
    attr_accessor :auth

    def initialize(username, password)
      self.auth = {:username => username, :password => password}
    end
    
    def get_listing(options={})
      response = HTTParty.get(SodaXmlTeam::Address.build("get_listing", options), :basic_auth => self.auth, :verify => false)
      Nokogiri::XML(response.body)
    end

    def get_document(options={})
      response = HTTParty.get(SodaXmlTeam::Address.build("get_document", options), :basic_auth => self.auth, :verify => false)
      Nokogiri::XML(response.body)
    end

  end
end