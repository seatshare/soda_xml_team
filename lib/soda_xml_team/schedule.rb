##
# SODA XML Team module
module SodaXmlTeam
  require 'nokogiri'

  ##
  # Schedule class
  class Schedule
    ##
    # Parses schedule documents into hashes
    # - document: a Nokegiri::XML::Document
    def self.parse_schedule(document = {})
      output = []

      fail 'Invalid XML schedule.' unless document.is_a? Nokogiri::XML::Document

      document.css('schedule sports-event').each do |event|

        row = {}

        event.css('event-metadata').each do |eventmeta|
          row[:event_key] = eventmeta['event-key']
          row[:start_date_time] = DateTime.parse(eventmeta['start-date-time'])
          row[:time_certainty] = eventmeta['time-certainty']
          eventmeta.css('site name').each do |sitemeta|
            row[:site] = sitemeta['full']
          end
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

      output
    end
  end
end
