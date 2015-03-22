class Article < ActiveRecord::Base

  belongs_to :user

  validates :title, length: { in: 4..128 }

  validates :content, presence: true

  validates :image,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 5.megabytes }

  has_attached_file :image, styles: {
                              thumb: '100x100>',
                              square: '200x200#',
                              medium: '300x300>'
                          }

end
