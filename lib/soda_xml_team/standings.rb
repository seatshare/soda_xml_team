##
# SODA XML Team module
module SodaXmlTeam
  require 'nokogiri'

  ##
  # Standings class
  class Standings
    ##
    # Parses standings documents into hashes
    # - document: a Nokegiri::XML::Document
    def self.parse_standings(document = {})
      output = []

      fail 'Invalid XML standings.' unless
        document.is_a? Nokogiri::XML::Document

      document.css('sports-content standing').each do |division|

        row = {}
        row[:division] = division['content-label']

        division.css(
          'sports-content-codes sports-content-code[code-type="conference"]'
        ).each do |standingmetadata|
          row[:conference] = standingmetadata['code-name']
        end

        row[:teams] = []

        division.css('team').each do |team|

          team_record = {}

          team.css('team-metadata name').each do |tmn|
            team_record[:name] = "#{tmn[:first]} #{tmn[:last]}"
          end

          team.css('team-stats').each do |teamstats|
            next if teamstats['standing-points'].nil?
            team_record[:standing_points] = teamstats['standing-points'].to_i
          end

          team.css('team-stats rank').each do |tsr|
            team_record[:division_rank] = tsr[:value].to_i
            team_record[:conference_rank] = tsr['xts:conference-rank'].to_i
          end

          team.css('team-stats outcome-totals').each do |ot|
            next if ot['competition-scope'] != 'league'
            next if ot['date-coverage-type'] != 'season-regular'
            next unless ot['duration-scope'].nil?
            next unless ot['alignment-scope'].nil?
            ot.keys.each do |otk|
              begin
                team_record[otk] = ot[otk].to_i if Float(ot[otk])
              rescue
                team_record[otk] = ot[otk]
              end
            end
          end

          row[:teams] << team_record

        end

        output << row
      end

      output
    end
  end
end
