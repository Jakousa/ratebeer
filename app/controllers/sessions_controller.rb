class SessionsController < ApplicationController
  def new
    # renderöi kirjautumissivun
  end

  def create
    user = User.find_by username: params[:username]
    # tarkastetaan että käyttäjä olemassa, ja että salasana on oikea
    return redirect_to signin_path, notice: "username and password do not match" if !user&.authenticate(params[:password])

    return redirect_to signin_path, notice: "Your account is frozen, please contact admin" if user.blocked

    session[:user_id] = user.id
    redirect_to user_path(user), notice: "Welcome back!"
  end

  def destroy
    # nollataan sessio
    session[:user_id] = nil
    # uudelleenohjataan sovellus pääsivulle
    redirect_to :root
  end
end
