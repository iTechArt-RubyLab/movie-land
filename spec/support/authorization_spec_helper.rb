module AuthorizationSpecHelper
  def sign_up(user)
    post '/auth/',
         params: { email: user.email,
                   password: user.password,
                   password_confirmation: user.password,
                   username: user.username,
                   name: user.name,
                   surname: user.surname,
                   birthday: user.birthday },
         as: :json
  end

  def sign_in(user)
    post '/auth/sign_in/',
         params: { email: user.email, password: user.password },
         as: :json

    response.headers.slice('client', 'access-token', 'uid')
  end
end
