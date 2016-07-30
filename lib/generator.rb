require "erb"
require "mechanize"

class Generator
  AGENT = Mechanize.new

  URL = "http://steno.tu-clausthal.de/Gregg.php?DIR=Gregg&Proof=0&Scherung=22.5&Tilt=0.0&Input="

  def self.fetch_image!(text)
    image = AGENT.get(url(text)).image_with(src: /^catgif.php/)
    image.fetch.save(image_path(text))
  end

  def self.url(text)
    escaped_text = ERB::Util.url_encode(text)
    url = "#{URL}#{escaped_text}"
  end

  def self.image_path(text)
    File.join(Dir.tmpdir, "GREGGBOT_#{image_basename(text)}.gif")
  end

  def self.image_basename(text)
    text.strip.gsub(/[[:punct:]]/, "").gsub(/\s+/, "_").downcase
  end
end
