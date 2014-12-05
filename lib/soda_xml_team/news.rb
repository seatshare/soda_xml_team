##
# SODA XML Team module
module SodaXmlTeam
  require 'nokogiri'

  ##
  # News class
  class News
    ##
    # Parses news documents into hashes
    # - document: a Nokegiri::XML::Document
    def self.parse_news(document = {})
      output = []

      fail 'Invalid XML news.' unless document.is_a? Nokogiri::XML::Document

      output = {}

      # Article meta data
      document.css('sports-content').each do |metadata|
        output[:title] = metadata.css('sports-title').first.content
        unless metadata.css('byline person').empty?
          output[:author] = metadata.css('byline person').first.content
        end
        output[:author_title] = metadata.css('byline byttl').first.content
        output[:headline] = metadata.css('article hedline hl1').first.content
        output[:abstract] = metadata.css('article abstract')
          .first.content.gsub(/\n/, '').strip
      end

      # Article content
      document.xpath(
        '/xts:sports-content-set/sports-content/article/nitf/body/body.content'
      ).each do |article_body|
        output[:body] = article_body.css('*').to_s.gsub(/\n/, '').strip
      end

      output
    end
  end
end
