class UsersController < ApplicationController
  ######## For SMS Gateway ##############
  require 'net/http'
  require 'uri'
####################################

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user }
    end
  end

  def new
    @user = User.new
    @user.build_user_profile

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    charset = %w{ 1 2 3 4 5 6 7 8 9 0}
    @user.verification_code = (0...7).map { charset.to_a[rand(charset.size)] }.join

    respond_to do |format|
      if @user.save
        #sms_status
        format.html { redirect_to(new_user_path, :notice => 'User was successfully created.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml { head :ok }
    end
  end

  def sms_status
    mobile = @user.mobile_number
    message = "Dear VLE, Your activation code for CSC Portal is "+@user.verification_code+".Please use this code to complete your registration.Vedavaag Systems Limited."
    url = "http://voice.full2ads.co.cc/api/sms.php?uid=6368616974616e7961&pin=4e4ce8b0a500c&sender=SARKCSC&route=1&mobile=#{mobile},&message=#{message}"
    Net::HTTP.get_print URI.parse(URI.encode(url.strip))

  end

  def confirm
    render
  end
  def verification
    @user = User.where(:verification_code => params[:verification_code]).first

    if @user.blank?
     flash[:error] = "Invalid verification code. Please check once again"
      redirect_to confirm_users_path
    else
      if @user.approved?
        flash[:error] = "The code is already verified."
        redirect_to confirm_users_path
      else
        @user.approved = true
        @user.save
        flash[:notice] = "Congratulations. The verification code approved."
        redirect_to confirm_users_path
      end
    end
  end
end
