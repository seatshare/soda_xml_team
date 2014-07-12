module SodaXmlTeam

  require 'nokogiri'

  class Schedule

    def self.parse_schedule(document={})

      output = []

      unless document.is_a? Nokogiri::XML::Document
        raise "Invalid XML schedule."
      end

      document.css('schedule sports-event').each do |event|

        row = {}

        event.css('event-metadata').each do |eventmeta|
          row[:event_key] = eventmeta['event-key']
          row[:start_date_time] = eventmeta['start-date-time']
        end
        event.css('team team-metadata[alignment="away"]').each do |away_team|
          team_name = away_team.css('name').first
          row[:away_team_id] = away_team['team-key']
          row[:away_team] = "#{team_name['first']} #{team_name['last']}"
        end
        event.css('team team-metadata[alignment="home"]').each do |home_team|
          team_name = home_team.css('name').first
          row[:home_team_id] = home_team['team-key']
          row[:home_team] = "#{team_name['first']} #{team_name['last']}"
        end
        output << row
      end

      return output

    end

  end

end