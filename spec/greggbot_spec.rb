require_relative 'support/fakeweb'

RSpec.describe Greggbot do
  context "with good credentials" do
    subject(:bot) { Greggbot.new("config.yaml") } # TODO: create test account

    before(:all) do
      #$stderr.reopen(File.new("/dev/null", "w"))

      FakeWeb.register_with_fixtures([
        'https://api.twitter.com/1.1/account/verify_credentials.json',
        'https://api.twitter.com/1.1/lists/statuses.json',
      ])
    end

    it "should succeed with good credentials" do
      bot.login!
      expect(bot.twitter.user).to_not be_nil
    end

    context "when getting tweets from the list" do
      it "should find tweets" do
        bot.login!
        expect(bot.tweets.count).to be > 0
      end

      it "should only get new tweets since last run"
    end

    context "when exiting" do
      it "should delete all temp images"
    end
  end

  context "with bad credentials" do
    subject(:bot) { Greggbot.new("config.yaml.example") }

    before(:all) do
      FakeWeb.clean_registry
      FakeWeb.register_uri(
        :get,
        %r"https://api\.twitter\.com/1\.1/account/verify_credentials\.json.*",
        :status => ["401", "Unauthorized"]
      )
    end

    it "should read secret keys & tokens" do
      expect(bot.access_token).to    eq("ACCESS TOKEN")
      expect(bot.access_secret).to   eq("ACCESS TOKEN SECRET")
      expect(bot.consumer_key).to    eq("CONSUMER API KEY")
      expect(bot.consumer_secret).to eq("CONSUMER API SECRET")
    end

    it "should set the logger level" do
      expect(bot.logger.level).to eq(Logger::DEBUG)
    end

    it "should set the source list name" do
      expect(bot.source_list_name).to eq("Sources")
    end

    it "should fail to log in" do
      bot.login!
      expect { bot.twitter.user }.to raise_error(Twitter::Error::Unauthorized)
    end
  end
end
