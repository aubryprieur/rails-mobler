class Search
  include ActiveModel::Model
  attr_accessor :category,
                :length,
                :width,
                :height,
                :min_height,
                :max_height,
                :min_width,
                :max_width,
                :min_length,
                :max_length

  def min_length
    length.split(',')[0]
  end

  def max_length
    length.split(',')[1]
  end

  def min_height
    height.split(',')[0]
  end

  def max_height
    height.split(',')[1]
  end

  def min_width
    width.split(',')[0]
  end

  def max_width
    width.split(',')[1]
  end

end
