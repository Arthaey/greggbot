def expected_filename(actual_filename)
	File.join(File.dirname(__FILE__), "fixtures/EXPECTED_#{actual_filename}.gif")
end

RSpec.describe Generator do
  before(:all) { $stderr.reopen(File.new("/dev/null", "w")) }

  after(:all) do
    tmp_files = File.join(Dir.tmpdir, "GREGGBOT_*.gif")
    File.delete(*Dir.glob(tmp_files))
  end

  context "when constructing image filenames" do
    it "should remove all whitespace & punctuation" do
      expect(Generator.image_basename("Foo & bar!")).to eq("foo_bar")
    end

    it "should use a tmp directory" do
      expected_path = "#{Dir.tmpdir}/GREGGBOT_foo_bar.gif"
      expect(Generator.image_path("Foo & bar!")).to eq(expected_path)
    end
  end

  context "when constructing URLs" do
    it "should escape all whitespace & punctuation" do
      expected_url = "#{Generator::URL}Foo%20%26%20bar%21"
      expect(Generator.url("Foo & bar!")).to eq(expected_url)
    end
  end

  context "when fetching images" do
    it "should fetch an image for a single word" do
      path = Generator.fetch_image!("hello")
      expect(path).to be_same_file_as(expected_filename("hello"))
    end

    it "should fetch an image for multiple words" do
      path = Generator.fetch_image!("Hello, world!")
      expect(path).to be_same_file_as(expected_filename("hello_world"))
    end
  end
end
