require "logger"

# from http://stackoverflow.com/a/6768164/1867798
module Logging
  def logger
    Logging.logger
  end

  def self.logger
    @logger ||= Logger.new($stdout)

    @logger.formatter = proc do |severity, _datetime, _progname, msg|
      prefix = "[#{severity}]"
      "#{prefix.ljust(8)} #{msg}\n"
    end

    @logger
  end
end
