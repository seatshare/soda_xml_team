require 'spec_helper'

describe "SodaXmlTeamSchedule" do

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

  end
end