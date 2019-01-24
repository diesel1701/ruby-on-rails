class Article < ApplicationRecord
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image, styles: { medium: "550x550>", thumb: "200x200>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  def tag_list
    self.tags.map do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").map{ |x| x.strip.downcase}.uniq
    new_or_found_tags = tag_names.map { |tag| Tag.find_or_create_by(name: tag) }
    self.tags = new_or_found_tags
  end

end
