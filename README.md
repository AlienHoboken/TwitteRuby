#TwitteRuby Gem

TwitteRuby is a wrapper library for the Twitter API, written in Ruby and utilizing reflection. TwitteRuby can be used to retrieve the raw JSON from the API calls, and optionally parse it into a Ruby data structure.

Due to its reflection nature, TwitteRuby supports all current and hopefully future API calls due to this design.

##Installation

	gem install twitteruby

##Usage

Include TwitteRuby

	require "twitteruby"

Instantiate a new TwitteRuby object, passing in your credentials. At this time TwitteRuby only supports single-user mode, that may change.

	twit = TwitteRuby.new(oauth_consumer_key, oauth_consumer_secret, oauth_token, oauth_token_secret, "https://api.twitter.com/1.1/")

Next call any of the [Twitter API Functions](https://dev.twitter.com/docs/api/1.1) methods by calling a method on the TwitteRuby object formed in the following way: Fist the http method (GET/POST) in all lower case followed by an underscore, and replace all back slashes (/) with two underscores. 

So the method:
	GET statuses/user_timeline"

becomes

    my_twitteruby.get_statuses__user_timeline

This may seem a little fuzzy at first, but it's how TwitteRuby uses reflection to support all current and future Twitter API calls.

A convenience function `parseJSON` is provided which will parse all JSON into a Ruby data structure.

So a complete example might look like:
	require "twitteruby"

	#make sure to fill in the credentials
	twit = TwitteRuby.new(oauth_consumer_key, oauth_consumer_secret, oauth_token, oauth_token_secret, "https://api.twitter.com/1.1/")

	#get all statuses from the timeline as JSON
	json_data = twit.get_statuses__user_timeline()

	#use convenience method to parse it into a Ruby data structure
	data = twit.parseJSON(json_data)

	#do something with it

##Contributing

If you wish to contribute, make your changes then issue a pull request. I'll review all changes before pulling.