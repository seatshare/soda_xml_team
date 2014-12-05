##
# SODA XML Team module
module SodaXmlTeam
  require 'httparty'
  require 'nokogiri'

  ##
  # Client for interacting with API
  class Client
    def initialize(username, password)
      @auth = { username: username, password: password }
      @dir = File.dirname __FILE__
    end

    ##
    # Content Finder retrieves an RSS feed of desired data
    def content_finder(options = {})
      response = HTTParty.get(
        SodaXmlTeam::Address.build(
          'get_listing',
          options
        ),
        basic_auth: @auth,
        ssl_ca_file: "#{@dir}/../ca-certificates.crt",
        ssl_version: :SSLv3
      )
      feed = Nokogiri::XML(response.body)

      documents = []
      feed.css('item').each do |item|
        record = {}

        # Parse for document ID
        link = item.css('link').inner_text
        document_id = link.gsub(/(.*)?doc-ids=/i, '')

        record[:title] = item.css('title').inner_text
        record[:link] = link
        record[:document_id] = document_id
        record[:date] = DateTime.parse(item.xpath('./dc:date').inner_text)
        item.xpath('./sportsml:sports-content-codes').each do |sportscontent|
          sportscontent.xpath('./sportsml:sports-content-code').each do |c|
            record[c['code-type'].to_sym] = c['code-key']
          end
        end

        documents << record
      end

      documents
    end

    ##
    # Deprecated: Please use `content_finder` instead
    def get_listing(options = {})
      warn '[DEPRECATION] `get_listing` is deprecated. Please use `content_finder` instead.'
      response = HTTParty.get(
        SodaXmlTeam::Address.build(
          'get_listing',
          options
        ),
        basic_auth: @auth,
        ssl_ca_file: "#{@dir}/../ca-certificates.crt",
        ssl_version: :SSLv3
      )
      Nokogiri::XML(response.body)
    end

    ##
    # Get Document retrieves a parsed XML instance of a given document
    def get_document(options = {})
      response = HTTParty.get(
        SodaXmlTeam::Address.build(
          'get_document',
          options
        ),
        basic_auth: @auth,
        ssl_ca_file: "#{@dir}/../ca-certificates.crt",
        ssl_version: :SSLv3
      )
      Nokogiri::XML(response.body)
    end
  end
end
