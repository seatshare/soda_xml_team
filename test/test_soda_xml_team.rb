require 'test/unit'
require 'soda_xml_team'
require 'openssl'

class SodaXmlTeamTest < Test::Unit::TestCase

  def setup
    if ENV['SODA_USERNAME'].nil? || ENV['SODA_PASSWORD'].nil?
      raise "Must provide a SOAP_USERNAME and SOAP_PASSWORD environment variable to run tests."
    end
  end

  def test_get_listing
    soda = SodaXmlTeam::Client.new(ENV['SODA_USERNAME'], ENV['SODA_PASSWORD'])
    listing = soda.get_listing({
      sandbox: true,
      league_id: 'l.nhl.com',
      team_id: 'l.nhl.com-t.19',
      type: 'schedule-single-team',
      start_datetime: DateTime.parse('2010-01-01 00:00:00 CDT'),
      end_datetime: DateTime.parse('2011-01-01 00:00:00 CDT')
    })
    assert_equal 7, listing.css('item').length
  end

  def test_get_document
    soda = SodaXmlTeam::Client.new(ENV['SODA_USERNAME'], ENV['SODA_PASSWORD'])
    document = soda.get_document({
      sandbox: true,
      document_id: 'xt.10875359-nas-sked'
    })
    assert_equal 1, document.css('schedule').length, "1 instance of schedule"
    assert_equal 82, document.css('schedule sports-event').length, "82 games in a season"
  end

  def test_parse_schedule
    soda = SodaXmlTeam::Client.new(ENV['SODA_USERNAME'], ENV['SODA_PASSWORD'])
    document = soda.get_document({
      sandbox: true,
      document_id: 'xt.10875359-nas-sked'
    })
    schedule = SodaXmlTeam::Schedule.parse_schedule(document)
    assert_equal 82, schedule.length, "82 games in a season"
  end

end
