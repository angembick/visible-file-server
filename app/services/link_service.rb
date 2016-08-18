class LinkService

  def self.create_link(data)
    host_1 = Host.get_or_create(data[:host_1])
    host_2 = Host.get_or_create(data[:host_2])
    description = Description.get_or_create(data[:description])

    link = Link.new()
    link.description = description
    link.hosts << host_1
    link.hosts << host_2
    puts link.hosts
    link.save
  end

  def self.get_all_links
    all_links = []
    Link.all.each do |this_link|
      link = LinkService.make_link_human_readable(this_link)
      all_links << link
    end
    return all_links
  end

  def self.make_link_human_readable(this_link, from_host_name = nil)
    hosts = this_link.hosts.to_a
    description = this_link.description.text
    if from_host_name.present?
      host_1 = hosts.select{|host| host.name == from_host_name}.first.name
      hosts.reject!{|host| host.name == from_host_name}
    else
      host_1 = hosts.first.name
    end
    host_2 = hosts.last.name
    display_link = {
      host_1: host_1, 
      host_2: host_2,
      description: description
    }
    return display_link
  end

  def self.get_link_for_path(path)
    links = Host.find_by(name: path[0]).links.to_a
    links.reject!{|link| !(link.hosts.include?(Host.find_by(name: path[1])))}
    return links.first
  end

end