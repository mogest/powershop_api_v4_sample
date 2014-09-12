class Oauth2CallbackHandler
  def self.call(env)
    request = Rack::Request.new(env)

    secrets = Rails.application.secrets
    client = OAuth2::Client.new(secrets['oauth_client_id'], secrets['oauth_secret'], :site => secrets['oauth_site'])
    token = client.auth_code.get_token(request.params['code'], :redirect_uri => "#{request.scheme}://#{request.host_with_port}/callback")

    request.session[:authorization] = token.to_hash

    [302, {"Location" => "/"}, []]
  end
end
