class LinksController < ApplicationController

  def create
    link_data = {
        host_1: link_params[:host_1],
        host_2: link_params[:host_2],
        description: link_params[:description]
      }
    unless link_data.select{|data| data.nil?}.present?
      LinkService.create_link(link_data)
    end
    return render status: 200, json: {status: "success"}
  end

  def show
    return render status: 200, json: {links: LinkService.get_all_links}
  end

  private

  def link_params
    params.permit(:description, :host_1, :host_2 )
  end
end