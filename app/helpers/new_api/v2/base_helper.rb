module NewApi::V2::BaseHelper

  def error(status, message)
    render json: {error: {status: status, message: message}}
  end

  def success(message)
    render json: {success: 1, message: message}
  end

end