class Description < ActiveRecord::Base
  has_many :links

  def self.get_or_create(desc_text)
    description = Description.find_by(text: desc_text)
    if description.nil?
      description = Description.create(text: desc_text)
    end
    return description
  end

end
