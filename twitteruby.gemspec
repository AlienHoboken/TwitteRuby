Gem::Specification.new do |s|
	s.name  = 'TwitteRuby'
	s.version       = '1.0.1'
	s.date  = '2014-02-17'
	s.summary       = "Twitter API Wrapper"
	s.description   = "A Ruby reflection based wrapper library for the Twitter API"
	s.author= 'Jeremiah Johnson'
	s.email = 'jeremiah@jwjdev.com'
	s.files = ["lib/twitteruby.rb"]
	s.license       = 'MIT'
	s.cert_chain  = ['certs/alienhoboken.pem']
	s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/
	s.add_runtime_dependency "oauth", '~> 0.4.7'
	s.add_runtime_dependency "json", '~> 1.8.1'
end
