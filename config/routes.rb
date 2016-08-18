Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  post 'host' => 'hosts#create'
  get 'hosts' => 'hosts#show'

  #Links need the names of the two hosts being connected and a description of the link.
  post 'link' => 'links#create'
  get 'links' => 'links#show'

  #retrieve the easiest way to transfer a file between host A and host B, ordered correctly
  #If there is no path between the hosts, return an empty array
  get 'path/:A/to/:B' => 'path#find_shortest_path'

end
