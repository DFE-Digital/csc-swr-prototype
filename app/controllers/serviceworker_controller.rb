class ServiceworkerController < ApplicationController
  protect_from_forgery except: :service_worker
  layout false

  def service_worker
  end

  def offline
  end
end