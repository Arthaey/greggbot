require 'logger'
require 'yaml'

class Greggbot

  LOGGER = Logger.new($stdout)
  LOGGER.level = :debug
  LOGGER.formatter = proc do |severity, datetime, progname, msg|
    prefix = "[#{severity}]"
    "#{prefix.ljust(8)} #{msg}\n"
  end

  attr_reader :access_token, :access_secret
  attr_reader :consumer_key, :consumer_secret

  def initialize(config_filename)
    config = YAML.load_file(config_filename)

    @access_token    = config[:access_token]
    @access_secret   = config[:access_secret]
    @consumer_key    = config[:consumer_key]
    @consumer_secret = config[:consumer_secret]

    # TODO: set logger level in config file
  end

  def run
    LOGGER.info("Started at #{now}.")

    # log in
    # get list
    # get new tweets from list
    # limit to N tweets
    # for each tweet:
      # send text to generator
      # save image
      # public-reply to tweet with the image

    LOGGER.info("Finished at #{now}.")
  end

  private

  def now
    Time.now.strftime("%F %T %z")
  end

end
