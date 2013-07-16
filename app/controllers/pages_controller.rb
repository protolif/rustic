class PagesController < ApplicationController
  def home
  end

  def search
    @fname_results = User.where('lower(fname) SIMILAR TO ?', "%#{params[:q]}%").order('fname')
    @lname_results = User.where('lower(lname) SIMILAR TO ?', "%#{params[:q]}%").order('lname')
    @tel_results   = User.where('tel SIMILAR TO ?',  "%#{params[:q]}%").order('fname')
    @tel2_results  = User.where('tel2 SIMILAR TO ?', "%#{params[:q]}%").order('fname')
  end
end
