# SODA XML Team Gem

[![Gem Version](https://badge.fury.io/rb/soda_xml_team.svg)](http://badge.fury.io/rb/soda_xml_team) [![Build Status](https://travis-ci.org/seatshare/soda_xml_team.png)](https://travis-ci.org/seatshare/soda_xml_team)

This [gem](http://rubygems.org/gems/soda_xml_team) serves as an interface to the [SODA (Sports On Demand API) from XML Team](http://www.xmlteam.com/soda/). It uses [HTTParty](http://johnnunemaker.com/httparty/) and [Nokogiri](http://nokogiri.org/) to retrieve and parse the data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'soda_xml_team'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install soda_xml_team
```

## Usage

## Get a list of documents

The SODA service works by keeping revisions of various documents (schedules, news, injury reports, etc.) that you are charged pre-paid credit for downloading. It is currently does not cost any credits to obtain the list of available documents.

```ruby
soda = SodaXmlTeam::Client.new('your_username', 'your_password')
listing = soda.content_finder({
  # Set sandbox to true if you are browsing the trial dataset
  sandbox: false,
  league_id: 'l.nhl.com',
  team_id: 'l.nhl.com-t.19',
  type: 'schedule-single-team',
  start_datetime: '2010-01-01 00:00:00 CDT',
  end_datetime: '2011-01-01 00:00:00 CDT'
})

# An array of documents matching your query
puts listing.inspect
```

## Get a single document

Once you have this listing, you can obtain the individual document. As each document costs a credit _per download (even if you download the same version again)_, it is recommended that you cache / index this data somewhere in your application to avoid quickly depleting your credit balance.

```ruby
soda = SodaXmlTeam::Client.new('your_username', 'your_password')
document = soda.get_document({
  # Set sandbox to true if you are browsing the trial dataset
  sandbox: false,
  document_id: 'xt.10875359-nas-sked'
})

# A Nokogiri XML representation of the document contents
puts document.inspect
```

## Bespoke Methods

For some of the more common data types, the gem will create a native ruby representation of the data if you run it through one of the parsing methods.

### Schedule Parser

```ruby
soda = SodaXmlTeam::Client.new('your_username', 'your_password')
schedule_document = soda.get_document({
  sandbox: true,
  document_id: 'xt.10875359-nas-sked'
})
schedule = SodaXmlTeam::Schedule.parse_schedule(schedule_document)

# This is now available as an array of values
puts schedule.inspect
```

### News Parser

```ruby
soda = SodaXmlTeam::Client.new('your_username', 'your_password')
news_document = soda.get_document({
  sandbox: true,
  document_id: 'xt.3329967-NAS-2005-OUTLOOK'
})
article = SodaXmlTeam::Schedule.parse_news(news_document)

# This is now available as an array of values
puts article.inspect
```

### Standings Parser

```ruby
soda = SodaXmlTeam::Client.new('your_username', 'your_password')
standings_document = soda.get_document({
  sandbox: true,
  document_id: 'xt.10878197-standings'
})
standings = SodaXmlTeam::Standings.parse_standings(standings_document)

# This is now available as an array of values
puts standings.inspect
```

### League Directory File Parser

This gem includes an executable for parsing files from the [SODA League Directory](http://private.xmlteam.com/league-directory/), which is useful for handling a particular sports league.

```bash
$ soda-league-directory ~/Downloads/xt.20140505T114154-0400.l.afa.ar.primera-leaguedir.xml
[{:import_key=>"o.afa.ar-t.113", :entity_name=>"Argentinos Juniors ", :status=>1, :entity_type=>"l.afa.ar.primera"}, {:import_key=>"o.afa.ar-t.92", :entity_name=>"Arsenal de Sarandi ", :status=>1, :entity_type=>"l.afa.ar.primera"}, ... ]
```

## Contributing

1. Fork it ( https://github.com/seatshare/soda_xml_team/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
