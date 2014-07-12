# SODA XML Team Gem

This gem serves as an interface to the [SODA (Sports On Demand API) from XML Team](http://www.xmlteam.com/soda/). It uses [HTTParty](http://johnnunemaker.com/httparty/) and [Nokogiri](http://nokogiri.org/) to retrieve and parse the data.

## Get a list of documents

The SODA service works by keeping revisions of various documents (schedules, news, injury reports, etc.) that you are charged pre-paid credit for downloading. It is currently does not cost any credits to obtain the list of available documents.

```
soda = SodaXmlTeam::Client.new('your_username', 'your_password')
listing = soda.get_listing({
  # Set sandbox to true if you are browsing the trial dataset
  sandbox: false,
  league_id: 'l.nhl.com',
  team_id: 'l.nhl.com-t.19',
  type: 'schedule-single-team',
  start_datetime: DateTime.parse('2010-01-01 00:00:00 CDT'),
  end_datetime: DateTime.parse('2011-01-01 00:00:00 CDT')
})

# A Nokogiri XML representation of the document list
puts listing.inspect
```

## Get a single document

Once you have this listing, you can obtain the individual document. As each document costs a credit _per download (even if you download the same version again)_, it is recommended that you cache / index this data somewhere in your application to avoid quickly depleting your credit balance.

```
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

```
soda = SodaXmlTeam::Client.new('your_username', 'your_password')
schedule_document = soda.get_document({
  sandbox: true,
  document_id: 'xt.10875359-nas-sked'
})
schedule = SodaXmlTeam::Schedule.parse_schedule(schedule_document)

# This is now available as an array of values
puts schedule.inspect
```