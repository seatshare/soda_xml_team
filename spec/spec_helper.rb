require 'soda_xml_team'
require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each) do

    if ENV['SODA_USERNAME'].nil? || ENV['SODA_PASSWORD'].nil?
      raise "Must provide a SOAP_USERNAME and SOAP_PASSWORD environment variable to run tests."
    end

    stub_request(:get, "https://#{ENV['SODA_USERNAME']}:#{ENV['SODA_PASSWORD']}@soda.xmlteam.com/api-trial/getListings?earliest-date-time=20100101T000000-0500&fixture-keys=schedule-single-team&latest-date-time=20110101T000000-0500&league-keys=l.nhl.com&max-result-count=10&revision-control=latest-only&stylesheet=sportsml2rss-1.0-s&team-keys=l.nhl.com-t.19").
      to_return(:status => 200, :body => File.new("spec/fixtures/get_listing.xml").read, :headers => {})

    stub_request(:get, "https://#{ENV['SODA_USERNAME']}:#{ENV['SODA_PASSWORD']}@soda.xmlteam.com/api-trial/getDocuments?doc-ids=xt.10875359-nas-sked").
      to_return(:status => 200, :body => File.new("spec/fixtures/get_document.xml").read, :headers => {})

  end
end