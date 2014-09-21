require 'spec_helper'

describe "SodaXmlTeam" do

  subject { SodaXmlTeam::Client.new(ENV['SODA_USERNAME'], ENV['SODA_PASSWORD']) }

  describe '.get_listing' do

    let(:input) {
      {
        sandbox: true,
        league_id: 'l.nhl.com',
        team_id: 'l.nhl.com-t.19',
        type: 'schedule-single-team',
        start_datetime: DateTime.parse('2010-01-01 00:00:00 CDT'),
        end_datetime: DateTime.parse('2011-01-01 00:00:00 CDT')
      }
    }
    let(:output) { subject.get_listing(input) }

    it 'has seven items' do
      expect(output.css('item').length).to eq 7
    end

    it 'has a title that matches' do
      expect(output.css('item title').first.content).to eq "2010 Nashville Predators Schedule"
    end

  end

  describe '.get_document' do

    let(:input) {
      {
        sandbox: true,
        document_id: 'xt.10875359-nas-sked'
      }
    }
    let(:output) { subject.get_document(input) }

    it 'has one schedule node' do
      expect(output.css('schedule').length).to eq 1
    end

    it 'has 82 games in a season' do
      expect(output.css('schedule sports-event').length).to eq 82
    end

  end

end