module SodaXmlTeam

  require 'nokogiri'

  class Standings

    def self.parse_standings(document={})

      output = []

      unless document.is_a? Nokogiri::XML::Document
        raise "Invalid XML standings."
      end

      document.css('sports-content standing').each do |division|

        row = {}
        row[:division] = division['content-label']

        division.css('standing-metadata sports-content-codes sports-content-code[code-type="conference"]').each do |standingmetadata|
          row[:conference] = standingmetadata['code-name']
        end

        row[:teams] = []

        division.css('team').each do |team|

          team_record = {}

          team.css('team-metadata name').each do |teammetaname|
            team_record[:name] = "#{teammetaname[:first]} #{teammetaname[:last]}"
          end

          team.css('team-stats').each do |teamstats|
            next if teamstats['standing-points'].nil?
            team_record[:standing_points] = teamstats['standing-points'].to_i
          end

          team.css('team-stats rank').each do |teamstatsrank|
            team_record[:division_rank] = teamstatsrank[:value].to_i
            team_record[:conference_rank] = teamstatsrank['xts:conference-rank'].to_i
          end

          team.css('team-stats outcome-totals').each do |outcometotals|
            next if outcometotals['competition-scope'] != "league"
            next if outcometotals['date-coverage-type'] != "season-regular"
            next if !outcometotals['duration-scope'].nil?
            next if !outcometotals['alignment-scope'].nil?
            outcometotals.keys.each do |outcometotalskey|
              team_record[outcometotalskey] = outcometotals[outcometotalskey].to_i if Float(outcometotals[outcometotalskey]) rescue team_record[outcometotalskey] = outcometotals[outcometotalskey]
            end
          end

          row[:teams] << team_record

        end

        output << row
      end

      return output

    end

  end

end