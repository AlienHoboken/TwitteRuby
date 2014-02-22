class TwitteRuby
	require "oauth"
	require "json"

	#pass in oauth credentials and base for API URIs
	def initialize(oauth_consumer_key, oauth_consumer_secret, oauth_token, oauth_token_secret, api_base)
		@api_base = api_base # the base of all URIs for this API
		# Exchange our oauth_token and oauth_token secret for the AccessToken instance
		@access_token = get_access_token(oauth_consumer_key, oauth_consumer_secret, oauth_token, oauth_token_secret)
	end

	#pass in desired HTTP method, API method to call, and parameters
	def request(method, call, args)
		call = "#{@api_base}#{call}.json?" 	#it's OK to have an extraneous ? symbol in case of no args
		params = {} 						#parameters used in POST calls, but passed empty to GET
		if(method == :get) 					#modify the URL for GET calls
			args.each{|arg| arg.map{|k,v| call += "#{k}=#{v}&"}} #extraneous ampersands are OK
		else 								#build full hash of all parameters for POST calls
			args.each{|arg| params = params.merge(arg)}
		end
		return @access_token.request(method, call, params).body
	end

	#refactor all API calls to methods with method_missing
	def method_missing(method_name, *args) 
		return request($1.to_sym, $2.gsub(/__/, '/'), args) if method_name =~ /^(post|get)_(.*)/ #only provide support for post_ and get_ missing methods
		super #chain to constructor incase not a post_ or get_
	end

	#parse JSON into a Ruby data structure
	def parseJSON(json)
		return JSON.parse(json)
	end
	
	private

	# Exchange our oauth_token and oauth_token_secret for an AccessToken instance.
	# Code written by Twitter Inc.
	def get_access_token(oauth_consumer_key, oauth_consumer_secret, oauth_token, oauth_token_secret)
		consumer = OAuth::Consumer.new(oauth_consumer_key, oauth_consumer_secret,
		{ :site => "http://api.twitter.com",
			:scheme => :header
		})
		# now create the access token object from passed values
		token_hash = { :oauth_token => oauth_token,
			:oauth_token_secret => oauth_token_secret
		}
		access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
		return access_token
	end
end