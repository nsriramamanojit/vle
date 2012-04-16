class UsersController < ApplicationController
  ######## For SMS Gateway ##############
  require 'net/http'
  require 'uri'
####################################

  def index
    @users = User.search(params[:search]).paginate(:page => params[:page], :per_page => 20)

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

    @panchayat = UserProfile.where(:panchayat_id => params[:user][:user_profile_attributes][:panchayat_id])


    if @panchayat.blank?

      charset = %w{ 1 2 3 4 5 6 7 8 9 0}
      @user.verification_code = (0...7).map { charset.to_a[rand(charset.size)] }.join


      respond_to do |format|
        if @user.save
          sms_status
          format.html { redirect_to(confirm_users_path, :notice => 'Verification code sent to Your mobile. Please enter the code to complete the registration process') }
          format.xml { render :xml => @user, :status => :created, :location => @user }
        else
          format.html { render :action => "new" }
          format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:error] = "The panchayat Already Registered. Your registration cannot be accepted"
      redirect_to new_user_path

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
    url = "http://www.smsginger.com/sendhttp.php?user=33602&password=chaitu1479&mobiles=#{mobile}&message=#{message}&sender=VEDCSC&route=4"
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
        district =District.find(@user.user_profile.district_id)
        district.increment!(:dis_number)
        vle_code= "BR" + district.short_code+"%04d" % district.dis_number
        @user.user_profile.vle_code= vle_code
        @user.email = vle_code.downcase.to_s + "@vedavaagcsc.in"

        @user.approved = true
        @user.verification_date = Time.now.strftime('%d-%m-%Y')

        @user.save
        flash[:notice] = "Congratulations. The verification code approved. Your registration is completed"
        redirect_to new_user_path
      end
    end
  end

  def load_districts
    @load_districts = District.where(:division_id => (params[:id])).order("name ASC")
    respond_to do |format|
      format.js
    end
  end

  def load_blocks
    @load_blocks = Block.where(:district_id => (params[:id])).order("name ASC")
    respond_to do |format|
      format.js
    end

  end

  def load_panchayats
    @load_panchayats = Panchayat.where(:block_id => (params[:id])).order("name ASC")

    respond_to do |format|
      format.js
    end

  end

  def export
    @users = User.all
    html = render_to_string :layout => false
    kit = PDFKit.new(html, :orientation => 'Landscape', :page_size => 'A4')
    send_data(kit.to_pdf, :filename => "Users_List"+".pdf", :type => 'application/pdf')
  end

  def export_csv
    require 'csv'
    @users = User.order('approved ASC')
    outfile = "User Report" + Time.now.strftime("%d-%m-%Y") + ".csv"
    csv_data = CSV.generate do |csv|
      csv << ["Status", "Name",  "Mobile", "Division", "District", "Block", "Panchayat"]
      @users.each do |user|
        csv << [user.approved? ? 'A' : 'P', user.name.titleize,  user.mobile_number, user.user_profile.division.name.titleize, user.user_profile.district.name.titleize, user.user_profile.block_id? ? user.user_profile.block.name.titleize : 'None', user.user_profile.panchayat.name.titleize]
      end
    end
    send_data csv_data,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=#{outfile}"

  end
  def pending
    @users = User.where(:approved => false).search(params[:search]).paginate(:page => params[:page], :per_page => 20)
  end
  def pending_export
    @users = User.where(:approved => false)
    html = render_to_string :layout => false
    kit = PDFKit.new(html, :orientation => 'Landscape', :page_size => 'A4')
    send_data(kit.to_pdf, :filename => "Users_Pending_List"+".pdf", :type => 'application/pdf')

  end
end

