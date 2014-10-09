module SodaXmlTeam

  require 'httparty'
  require 'nokogiri'

  class Client

    def initialize(username, password)
      @auth = {:username => username, :password => password}
      @dir = File.dirname __FILE__
    end

    def content_finder(options={})
      response = HTTParty.get(SodaXmlTeam::Address.build("get_listing", options), :basic_auth => @auth, :ssl_ca_file => "#{@dir}/../ca-certificates.crt", :ssl_version => :SSLv3)
      feed = Nokogiri::XML(response.body)

      documents = []
      feed.css('item').each do |item|
        record = {}

        # Parse for document ID
        link = item.css('link').inner_text
        uri = URI.parse(link)
        document_id = CGI.parse(uri.query)['doc-ids'].first

        record[:title] = item.css('title').inner_text
        record[:link] = link
        record[:document_id] = document_id
        record[:date] = DateTime.parse(item.xpath('./dc:date').inner_text)
        item.xpath('./sportsml:sports-content-codes').each do |sportscontent|
          sportscontent.xpath('./sportsml:sports-content-code').each do |content|
            record[content['code-type'].to_sym] = content['code-key']
          end
        end

        documents << record
      end

      return documents

    end

    # Deprecated: Please use `content_finder` instead
    def get_listing(options={})
      warn "[DEPRECATION] `get_listing` is deprecated.  Please use `content_finder` instead."
      response = HTTParty.get(SodaXmlTeam::Address.build("get_listing", options), :basic_auth => @auth, :ssl_ca_file => "#{@dir}/../ca-certificates.crt", :ssl_version => :SSLv3)
      Nokogiri::XML(response.body)
    end

    def get_document(options={})
      response = HTTParty.get(SodaXmlTeam::Address.build("get_document", options), :basic_auth => @auth, :ssl_ca_file => "#{@dir}/../ca-certificates.crt", :ssl_version => :SSLv3)
      Nokogiri::XML(response.body)
    end

  end
end
