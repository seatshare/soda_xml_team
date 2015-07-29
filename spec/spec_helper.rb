require 'soda_xml_team'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do

    if ENV['SODA_USERNAME'].nil? || ENV['SODA_PASSWORD'].nil?
      ENV['SODA_USERNAME'] = 'testuser'
      ENV['SODA_PASSWORD'] = 'testpassword'
    end

    stub_request(:get, "https://#{ENV['SODA_USERNAME']}:#{ENV['SODA_PASSWORD']}@soda.xmlteam.com/api-trial/getListings?earliest-date-time=20100101T000000-0500&fixture-keys=schedule-single-team&latest-date-time=20110101T000000-0500&league-keys=l.nhl.com&max-result-count=10&publisher-keys=sportsforecaster.com&revision-control=latest-only&stylesheet=sportsml2rss-1.0-s&team-keys=l.nhl.com-t.19")
      .to_return(status: 200, body: File.new('spec/fixtures/get_listing_schedule.xml').read, headers: {})

    stub_request(:get, "https://#{ENV['SODA_USERNAME']}:#{ENV['SODA_PASSWORD']}@soda.xmlteam.com/api-trial/getDocuments?doc-ids=xt.10875359-nas-sked")
      .to_return(status: 200, body: File.new('spec/fixtures/get_document_schedule.xml').read, headers: {})

    stub_request(:get, "https://#{ENV['SODA_USERNAME']}:#{ENV['SODA_PASSWORD']}@soda.xmlteam.com/api-trial/getDocuments?doc-ids=xt.3329967-NAS-2005-OUTLOOK")
      .to_return(status: 200, body: File.new('spec/fixtures/get_document_news.xml').read, headers: {})

    stub_request(:get, "https://#{ENV['SODA_USERNAME']}:#{ENV['SODA_PASSWORD']}@soda.xmlteam.com/api-trial/getDocuments?doc-ids=xt.10878197-standings")
      .to_return(status: 200, body: File.new('spec/fixtures/get_document_standings.xml').read, headers: {})

  end
end
