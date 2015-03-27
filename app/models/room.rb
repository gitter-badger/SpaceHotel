class Room < ActiveRecord::Base

  filterrific :default_filter_params => {sort_by: 'price_desc'},
              :available_filters => %w[
                sort_by
                with_date
                with_specification
                with_price
                with_size
                with_occupancy
              ]

  belongs_to :specification
  has_many :bookings

  validates :image,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 5.megabytes }

  has_attached_file :image, styles: {
                               thumb: '100x100>',
                               square: '200x200#',
                               medium: '300x300>'
                           }

  def self.options_for_sorted_by
    [
        ['Expensive first', 'price_desc'],
        ['Cheaper first', 'price_acs'],
        ['Larger first', 'size_desc'],
        ['Cheaper first', 'size_asc'],
        ['For more persons first', 'occupancy_desc'],
        ['For less persons first', 'occupancy_asc']
    ]
  end

  scope :sort_by, -> (sort_option) {
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^created_at_/
        order("rooms.created_at #{ direction }")
      when /^price_/
        order("rooms.price #{ direction }")
      when /^size_/
        order("rooms.size #{ direction }")
      when /^occupancy_/
        order("rooms.occupancy #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_date, -> (dates) {
    p dates
    all
  }

  scope :with_specification, -> (specification_ids) {
    where(:specification_id => specification_ids.split(','))
  }

  scope :with_price, -> (prices) {
    range = prices.split(',')
    where('rooms.price >= ? AND rooms.price <= ?', range[0], range[1])
  }

  scope :with_size, -> (sizes) {
    range = sizes.split(',')
    where('rooms.size >= ? AND rooms.size <= ?', range[0], range[1])
  }

  scope :with_occupancy, -> (occupancy) {
    range = occupancy.split(',')
    where('rooms.occupancy >= ? AND rooms.occupancy <= ?', range[0], range[1])
  }

end
