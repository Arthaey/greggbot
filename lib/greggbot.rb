require 'yaml'

class Greggbot

  attr_reader :access_token, :access_secret
  attr_reader :consumer_key, :consumer_secret

  def initialize(config_filename)
    config = YAML.load_file(config_filename)
    @access_token    = config[:access_token]
    @access_secret   = config[:access_secret]
    @consumer_key    = config[:consumer_key]
    @consumer_secret = config[:consumer_secret]
  end

end
