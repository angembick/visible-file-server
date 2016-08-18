class PathController < ApplicationController

  def find_shortest_path
    from = path_params[:A]
    to = path_params[:B]
    shortest_path = PathService.find_shortest_path(from,to)
    descriptive_shortest_path = PathService.get_details_for_each_link(shortest_path)
    return render status: 200, json: {result: descriptive_shortest_path}
  end

  private

  def path_params
    params.permit(:A, :B )
  end

end