module RedirectHelper
  def return_point(default=nil)
    redirect_to session[:return_point] ? session[:return_point] : default
    session.delete(:return_point)
  end

  def set_return_point(path)
    session[:return_point] = path
  end
end

