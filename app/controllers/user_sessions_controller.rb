# coding: utf-8
class UserSessionsController < ApplicationController
  def new
    store_referring_page
    @user_session = UserSession.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      if @user_session.save
        format.html { 
          flash[:notice] = "Vous êtes 'logged in'"
          redirect_back_or(home_path) 
        }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    store_referring_page
    @user_session = UserSession.find
    @user_session.destroy
    respond_to do |format|
      format.html { redirect_back_or(home_path) }
    end
  end

end
