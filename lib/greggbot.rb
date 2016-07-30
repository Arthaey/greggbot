require "twitter"
require "yaml"

require "logging"

class Greggbot
  include Logging

  attr_reader :access_token, :access_secret
  attr_reader :consumer_key, :consumer_secret
  attr_reader :source_list_name
  attr_reader :twitter

  def initialize(config_filename)
    config = YAML.load_file(config_filename)

    @access_token    = config[:access_token]
    @access_secret   = config[:access_secret]
    @consumer_key    = config[:consumer_key]
    @consumer_secret = config[:consumer_secret]

    @source_list_name = config[:source_list]

    logger.level = config[:log_level] || "INFO"
  end

  def run
    logger.debug("Started at #{now}.")

    login!

    tweets.each do |tweet|
      # send text to generator
      # save image
      # public-reply to tweet with the image
    end

    # delete tmp images

    logger.debug("Finished at #{now}.")
    logger.info("Done.")
  end

  def login!
    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = @consumer_key
      config.consumer_secret     = @consumer_secret
      config.access_token        = @access_token
      config.access_token_secret = @access_secret
    end
  end

  def tweets
    # get new tweets from list
    @twitter.list_timeline(@source_list_name, count: 2)
  end

  private

  def now
    Time.now.strftime("%F %T %z")
  end
end
