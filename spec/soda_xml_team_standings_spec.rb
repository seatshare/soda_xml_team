require 'spec_helper'

describe SodaXmlTeam do

  subject { SodaXmlTeam::Standings }

  describe '.parse_standings' do

    let(:input) do
      SodaXmlTeam::Client.new(
        ENV['SODA_USERNAME'], ENV['SODA_PASSWORD']
      ).get_document(
        sandbox: true,
        document_id: 'xt.10878197-standings'
      )
    end
    let(:output) { subject.parse_standings(input) }

    it 'has a division name' do
      expect(output[0][:division]).to eq 'Atlantic Division'
    end

    it 'has a conference name' do
      expect(output[0][:conference]).to eq 'Eastern'
    end

    it 'has five teams in the division' do
      expect(output[0][:teams].length).to eq 5
    end

    it 'has a team name' do
      expect(output[0][:teams][0][:name]).to eq 'New Jersey Devils'
    end

    it 'has a record of 10 wins' do
      expect(output[0][:teams][0]['wins']).to eq 37
    end

  end

end
