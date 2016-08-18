class Host < ActiveRecord::Base
  has_and_belongs_to_many :links

  def self.get_or_create(host_name)
    host = Host.find_by(name: host_name)
    if host.nil?
      host = Host.create(name: host_name)
    end
    return host
  end
end

