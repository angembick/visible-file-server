class PathService

  @distance_between_nodes = 1
  @infinity = 999999999

  def self.find_shortest_path(from_host_name, to_host_name)
    current_node, destination_node = {}, {}
    unvisited_nodes = []
    nodes = PathService.get_each_host_as_node
    nodes.each do | node|
      if node[:name] == from_host_name
        node[:distance] = 0
        current_node = node
      elsif node[:name] == to_host_name
        destination_node = node
      end
      unvisited_nodes << node
    end
    while true
      edges = PathService.get_edges_of(current_node[:name])
      edges.each do |edge|
        edge_node = unvisited_nodes.find{|node| node[:name] == edge.name}
        next if edge_node.blank?
        edge_distance = current_node[:distance] + @distance_between_nodes
        if edge_distance < edge_node[:distance]
          edge_node[:distance] = edge_distance
          path = current_node[:path].present? ? current_node[:path] + [[current_node[:name], edge[:name]]] : [[current_node[:name], edge[:name]]]
          edge_node[:path] = path 
        end
      end
      current_node[:status] = 'visited'
      puts destination_node[:path] if current_node[:name] == destination_node[:name] #status == 'visited'
      return destination_node[:path] if current_node[:name] == destination_node[:name] #status == 'visited'
      unvisited_nodes = nodes.select{|node| node[:status] == 'unvisited'}
      return [] if  unvisited_nodes.blank? || unvisited_nodes.select{|node| node[:distance] < @infinity}.blank?
      current_node = unvisited_nodes.min_by{|node| node[:distance] }
    end
  end

  def self.get_details_for_each_link(paths)
    descriptive_path = []
    paths.each do |path|
      this_link = LinkService.get_link_for_path(path)
      descriptive_path << LinkService.make_link_human_readable(this_link, path[0])
    end
    return descriptive_path
  end

  def self.get_edges_of(host_name)
    edges = []
    this_host = Host.find_by(name: host_name)
    hosts_links = this_host.links
    hosts_links.each{|link| edges << link.collect_other_host(host_name)}
    return edges
  end

  def self.get_each_host_as_node
    nodes = []
    Host.all.each do |host|
      this_node  = {
        id: host.id,
        name: host.name,
        distance: @infinity,
        status: 'unvisited',
        path: []
      }
      nodes << this_node
    end
    return nodes
  end

end