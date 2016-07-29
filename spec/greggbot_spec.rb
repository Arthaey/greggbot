RSpec.describe Greggbot do
  subject(:bot) { Greggbot.new("config.yaml.example") }

  context "with config file" do
    it "should read secret keys & tokens" do
      expect(bot.access_token).to    eq("ACCESS TOKEN")
      expect(bot.access_secret).to   eq("ACCESS TOKEN SECRET")
      expect(bot.consumer_key).to    eq("CONSUMER API KEY")
      expect(bot.consumer_secret).to eq("CONSUMER API SECRET")
    end

    it "should set the logger level" do
      expect(bot.logger.level).to eq(Logger::DEBUG)
    end
  end

  context "when logging in" do
    it "should succeed with good credentials"
    it "should fail with bad credentials"
  end
end
