require "yaml"

require "logging"

class Greggbot
	include Logging

  attr_reader :access_token, :access_secret
  attr_reader :consumer_key, :consumer_secret

  def initialize(config_filename)
    config = YAML.load_file(config_filename)

    @access_token    = config[:access_token]
    @access_secret   = config[:access_secret]
    @consumer_key    = config[:consumer_key]
    @consumer_secret = config[:consumer_secret]

    logger.level = config[:log_level] || "INFO"
  end

  def run
    logger.info("Started at #{now}.")

    # log in
    # get list
    # get new tweets from list
    # limit to N tweets
    # for each tweet:
    #  - send text to generator
    #  - save image
    #  - public-reply to tweet with the image

    logger.info("Finished at #{now}.")
  end

  private

  def now
    Time.now.strftime("%F %T %z")
  end
end
