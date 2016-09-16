class ImageWorker
  include Sidekiq::Worker

  # Decoding a received Base64 encoded image
  def perform(image_param, place_id)
    place = Place.find(place_id)

    if image_param.present?
      data = StringIO.new(Base64.decode64(image_param))
      data.class.class_eval {attr_accessor :original_filename, :content_type}
      data.original_filename = place.id.to_s + ".png"
      data.content_type = "image/png"
    end

    place.update_attribute(:image, data)
  end
end
