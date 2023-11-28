class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  
  validates :title, presence: true
  validates :opinion, presence: true
  
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'no-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
