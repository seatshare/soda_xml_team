require 'spec_helper'

describe 'SodaXmlTeamNews' do

  subject { SodaXmlTeam::News }

  describe '.parse_news' do

    let(:input) do
      SodaXmlTeam::Client.new(
        ENV['SODA_USERNAME'], ENV['SODA_PASSWORD']
      ).get_document(
        sandbox: true,
        document_id: 'xt.3329967-NAS-2005-OUTLOOK'
      )
    end
    let(:output) { subject.parse_news(input) }

    it 'has a article that matches' do
      expect(output[:title]).to eq '2005-06 Nashville Predators Preview'
      expect(output[:headline]).to eq '2005-06 Nashville Predators Preview'
      expect(output[:abstract]).to include 'The Nashville Predators were the'
      expect(output[:body]).to include '<p>(Sports  Network)  - The Nashville'
    end

  end
end
