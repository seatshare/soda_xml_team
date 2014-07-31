module SodaXmlTeam

  require 'httparty'
  require 'nokogiri'
  
  class Client
    
    include HTTParty
    debug_output $stderr

    def initialize(username, password)
      @auth = {:username => username, :password => password}
      @certs = 'lib/ca-bundle.crt'
    end
    
    def get_listing(options={})
      response = HTTParty.get(SodaXmlTeam::Address.build("get_listing", options), { :basic_auth => @auth, :ssl_ca_file => @certs })
      Nokogiri::XML(response.body)
    end

    def get_document(options={})
      response = HTTParty.get(SodaXmlTeam::Address.build("get_document", options), { :basic_auth => @auth, :ssl_ca_file => @certs })
      Nokogiri::XML(response.body)
    end

  end
end