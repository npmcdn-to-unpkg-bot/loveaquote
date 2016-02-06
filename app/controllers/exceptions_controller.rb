class ExceptionsController < ApplicationController
  def serve_404
    render(:status => 404)
  end

  def serve_500
    render(:status => 500)
  end
end
