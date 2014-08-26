require 'spec_helper'

describe SodaXmlTeam do

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

describe SodaXmlTeam do

  subject { SodaXmlTeam::Schedule }

  describe '.parse_schedule' do

    let(:input) {
      SodaXmlTeam::Client.new(ENV['SODA_USERNAME'], ENV['SODA_PASSWORD']).get_document({
        sandbox: true,
        document_id: 'xt.10875359-nas-sked'
      })
    }
    let(:output) { subject.parse_schedule(input) }

    it 'has 82 games in a season' do
      expect(output.length).to eq 82
    end

    it 'has expected home team' do
      expect(output[1][:home_team]).to eq 'Nashville Predators'
    end

    it 'has expected away team' do
      expect(output[1][:away_team]).to eq 'Colorado Avalanche'
    end

    it 'has expected start date/time' do
      expect(output[1][:start_date_time]).to eq DateTime.parse('October 8, 2009 7:00 PM CDT')
    end

    it 'has expected site' do
      expect(output[1][:site]).to eq 'Sommet Center'
    end

    it 'has expected time certainty' do
      expect(output[1][:time_certainty]).to eq 'certain'
    end

  end
end