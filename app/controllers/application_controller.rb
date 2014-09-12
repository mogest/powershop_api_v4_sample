class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_with_powershop

  protected

  def authenticate_with_powershop
    if session[:authorization].nil? || session[:authorization]['expires_at'].nil? || session[:authorization]['expires_at'] <= Time.now.to_i
      redirect_to client.auth_code.authorize_url(:redirect_uri => "#{request.protocol}#{request.host_with_port}/callback")
    end
  end

  def client
    secrets = Rails.application.secrets
    @oauth2_client ||= OAuth2::Client.new(secrets['oauth_client_id'], secrets['oauth_secret'], :site => secrets['oauth_site'])
  end

  def token
    OAuth2::AccessToken.from_hash(client, session[:authorization].dup)
  end
end
