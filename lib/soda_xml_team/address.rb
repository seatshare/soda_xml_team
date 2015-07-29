##
# SODA XML Team module
module SodaXmlTeam
  ##
  # Address class
  class Address < Client
    ##
    # Builds the query address against the API
    def self.build(method, options = {})
      path = []

      fail 'Invalid method.' unless %w(get_listing get_document).include? method

      # Get a listing of documents
      if method == 'get_listing'
        endpoint = '/getListings?'

        fail 'Must specify `league_id` (league-keys) or `team_id` (team-keys).' if options[:league_id].nil? && options[:team_id].nil?

        # League identifier
        path << "league-keys=#{options[:league_id]}" if options[:league_id]

        # Team identifier
        path << "team-keys=#{options[:team_id]}" if options[:team_id]

        # Document type
        if options[:type]
          path << "fixture-keys=#{options[:type]}"
        else
          fail 'Must specify the `type` (fixture-keys)'
        end

        # Start date/time
        if options[:start_datetime].is_a? String
          options[:start_datetime] = DateTime.parse(options[:start_datetime])
          path << "earliest-date-time=#{options[:start_datetime].strftime(
            '%Y%m%dT%H%M%S%z'
          )}"
        elsif options[:start_datetime].is_a? DateTime
          path << "earliest-date-time=#{options[:start_datetime].strftime(
            '%Y%m%dT%H%M%S%z'
          )}"
        end

        # End date/time
        if options[:end_datetime].is_a? String
          options[:end_datetime] = DateTime.parse(options[:end_datetime])
          path << "latest-date-time=#{options[:end_datetime].strftime(
            '%Y%m%dT%H%M%S%z'
          )}"
        elsif options[:end_datetime].is_a? DateTime
          path << "latest-date-time=#{options[:end_datetime].strftime(
            '%Y%m%dT%H%M%S%z'
          )}"
        end

        # Use a date window
        if options[:hours].is_a? Numeric
          path << "date-window=#{options[:hours]}00"
        end

        # Limit the number of listings returned returned
        if !options[:limit].nil? && options[:limit] > 0 && options[:limit] <= 50
          path << "max-result-count=#{options[:limit]}"
        else
          path << 'max-result-count=10'
        end

        # Priority
        path << "priorities=#{options[:priority]}" if options[:priority]

        # Which document revisions to return
        if options[:revisions] == 'all'
          path << 'revision-control=all'
        else
          path << 'revision-control=latest-only'
        end

        # Always return the XML listing
        path << 'stylesheet=sportsml2rss-1.0-s'

        # Select publisher database
        if options[:publisher].is_a? String
          path << "publisher-keys=#{options[:publisher]}"
        else
          path << 'publisher-keys=sportsforecaster.com'          
        end

      # Get a specific document
      else
        endpoint = '/getDocuments?'
        if options[:document_id]
          path << "doc-ids=#{options[:document_id]}"
        else
          fail 'Missing `document_id` (doc-ids)'
        end
      end

      # Concatenate it together
      path = path.join '&'

      # Use sandbox hostname or production
      if options[:sandbox] == true
        return SodaXmlTeam::API_SANDBOX_URL + endpoint + path
      else
        return SodaXmlTeam::API_BASE_URL + endpoint + path
      end
    end
  end
end
