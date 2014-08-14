class Entry < ActiveRecord::Base
  attr_accessible :description, :title, :original_url, :original_file_name, :thumb_url, :content_type

  validates_presence_of :original_url

  Format = Struct.new(:name, :extension, :width, :height, :quality)

  FORMATS = {
    video: Format.new("standard_video", "mp4", 640, 480, 3),
    image: Format.new("image", "jpg", 320, 240, 2)
  }

  def is_video?
    content_type =~ %r{^video/}
  end

  def is_image?
    content_type =~ %r{^image/}
  end

  def is_upload?
    !is_url?
  end

  def is_oembed?
    !!html
  end

  def has_thumb?
    !!thumb_url
  end

  def is_url?
    !original_file_name
  end

  before_create :process_oembed
  def process_oembed
    return true unless is_url?
    result = JSON.parse(OEmbed::Providers.raw(original_url, :format => :json))
    self.title = result['title']
    self.width = result['width']
    self.height = result['height']
    self.html = result['html']
    self.oembed_type = result['type']
    self.author_url = result['author_url']
    self.author_name = result['author_name']
    self.thumb_url = result['thumbnail_url']
    self.thumb_width = result['thumbnail_width']
    self.thumb_height = result['thumbnail_height']
    return true
  rescue OEmbed::NotFound => e
    return true
  end

  before_create :set_title
  def set_title
    self.title ||= self.original_file_name
  end

  after_create :zencode
  def zencode
    return unless is_video?
    return if zencoder_processed

    input = original_url.gsub('http://s3.amazonaws.com/', 's3://') # url format: s3://bucket/path/to/file.avi
    base_url = input.gsub(/[^\/]*$/, '') # trim non-path trailing chars, i.e. filename

    # set up the default transcoded URLs for each format
    self.processed_url = original_url.gsub(/[^\/]+$/, "#{format.name}.#{format.extension}")
    self.thumb_url = original_url.gsub(/[^\/]+$/, "thumb.jpg")

    zencoder_request = {
      :input => input,
      :output => [zencode_output_for(format, base_url)]
    }

    puts zencoder_request.inspect

    # create the zencoder job
    zencoder_response = Zencoder::Job.create(zencoder_request)

    puts zencoder_response.inspect

    # set the output ID for each format
    self.zencoder_output_id = zencoder_response.body["outputs"].first["id"]
    self.zencoder_processed = false

    self.save
  end

  def zencoder_processed!(width, height, duration)
    self.send("zencoder_processed=", true)
    self.send("width=", width)
    self.send("height=", height)
    self.duration = duration
    self.save!
  end

  private
  def basename
    original_file_name.split('.').first
  end

  def extension
    original_file_name.split('.').last
  end

  def format
    if is_image?
      FORMATS[:image]
    else
      FORMATS[:video]
    end
  end

  def host
    "droptab.herokuapp.com"
  end

  def zencode_output_for(format, base_url)
    {
      :base_url => base_url,
      :filename => "#{format.name}.#{format.extension}",
      :label => format.name,
      :notifications => [Rails.application.routes.url_helpers.zencoder_callback_url(:host => host)],
      # defaults
      # :video_codec => "h264",
      # :audio_codec => "aac",
      :quality => format.quality,
      :width => format.width,
      :height => format.height,
      :format => format.extension,
      :aspect_mode => "preserve",
      :public => 1,
      :thumbnails => {
        :format => "jpg",
        :number => 1,
        :base_url => base_url,
        :filename => "thumb",
        :public => 1
      }
    }
  end
end
