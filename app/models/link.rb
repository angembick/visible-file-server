class Link < ActiveRecord::Base
  belongs_to :description
  has_and_belongs_to_many :hosts

  def collect_other_host(host_name)
    links_hosts = self.hosts.to_a
    other_host = links_hosts.reject!{|host| host.name == host_name}
    return other_host.first
  end

end