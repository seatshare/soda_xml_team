module SodaXmlTeam

  require 'httparty'
  require 'nokogiri'

  class Client

    def initialize(username, password)
      @auth = {:username => username, :password => password}
      @dir = File.dirname __FILE__
    end

    def get_listing(options={})
      response = HTTParty.get(SodaXmlTeam::Address.build("get_listing", options), :basic_auth => @auth, :ssl_ca_file => "#{@dir}/../ca-certificates.crt", :ssl_version => :SSLv3)
      Nokogiri::XML(response.body)
    end

    def get_document(options={})
      response = HTTParty.get(SodaXmlTeam::Address.build("get_document", options), :basic_auth => @auth, :ssl_ca_file => "#{@dir}/../ca-certificates.crt", :ssl_version => :SSLv3)
      Nokogiri::XML(response.body)
    end

  end
end
