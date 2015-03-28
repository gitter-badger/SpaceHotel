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
    data_range = (Date.strptime(dates.partition(',').first, '%m/%d/%Y')..Date.strptime(dates.partition(',').last, '%m/%d/%Y'))
    where{id.not_in(Booking.where{(arrival.in data_range) | (departure.in data_range)}.select{distinct(`room_id`)})}
  }

  scope :with_specification, -> (specification_ids) {
    where(specification_id: specification_ids.split(','))
  }

  scope :with_price, -> (prices) {
    price_range = eval(prices.gsub(',','..'))
    where(price: price_range)
  }

  scope :with_size, -> (sizes) {
    size_range = eval(sizes.gsub(',','..'))
    where(size: size_range)
  }

  scope :with_occupancy, -> (occupancy) {
    occupancy_range = eval(occupancy.gsub(',','..'))
    where(occupancy: occupancy_range)
  }

end
