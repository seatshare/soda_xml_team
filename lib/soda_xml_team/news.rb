module SodaXmlTeam

  require 'nokogiri'

  class News

    def self.parse_news(document={})

      output = []

      unless document.is_a? Nokogiri::XML::Document
        raise "Invalid XML news."
      end

      output = {}

      # Article meta data
      document.css('sports-content').each do |metadata|
        output[:title] = metadata.css('sports-title').first.content
        if !metadata.css('byline person').empty?
          output[:author] = metadata.css('byline person').first.content
        end
        output[:author_title] = metadata.css('byline byttl').first.content
        output[:headline] = metadata.css('article hedline hl1').first.content
        output[:abstract] = metadata.css('article abstract').first.content.gsub(/\n/, "").strip
      end

      # Article content
      document.xpath('/xts:sports-content-set/sports-content/article/nitf/body/body.content').each do |article_body|
        output[:body] = article_body.css('*').to_s.gsub(/\n/, "").strip
      end

      return output

    end

  end

end