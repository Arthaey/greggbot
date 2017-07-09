module FakeWeb
  def self.register_with_fixtures(urls)
    FakeWeb.clean_registry

    urls.each do |url|
      filename = File.basename(url)
      url_regex = Regexp.compile(url.gsub('.', '\.') + '.*')
      response = File.read(File.join("spec", "fixtures", filename))
      FakeWeb.register_uri(:get, url_regex, :body => response)
    end
  end
end
