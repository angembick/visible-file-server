class HostsController < ApplicationController

  def create
    host_name = host_params[:name]
    unless host_name.nil? || Host.find_by(name: host_name).present?
      Host.create(name: host_name)
    end
    return render status: 200, json: {status: "success"}
  end

  def show
    return render status: 200, json: { hosts: Host.all.pluck(:name)}
  end

  private

  def host_params
    params.permit(:name)
  end
end
