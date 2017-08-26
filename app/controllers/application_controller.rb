class ApplicationController < ActionController::Base
  after_filter :return_errors, only: [:page_not_found]
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def page_not_found
    @status = 404
    @layout = "application"
    @template = "not_found_error"
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def return_errors
    respond_to do |format|
          format.html { render template: 'errors/' + @template, layout: 'layouts/' + @layout, status: @status }
          format.all  { render nothing: true, status: @status }
    end
  end

end
