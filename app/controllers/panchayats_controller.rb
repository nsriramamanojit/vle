class PanchayatsController < ApplicationController
  def index
    @panchayats = Panchayat.search(params[:search]).paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @panchayats }
    end
  end

  def show
    @panchayat = Panchayat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @panchayat }
    end
  end

  def new
    @panchayat = Panchayat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @panchayat }
    end
  end

  def edit
    @panchayat = Panchayat.find(params[:id])
  end

  def create
    @panchayat = Panchayat.new(params[:panchayat])
    @panchayat.state_id = 1

    respond_to do |format|
      if @panchayat.save
        format.html { redirect_to(panchayats_url, :notice => 'Panchayat was successfully created.') }
        format.xml  { render :xml => @panchayat, :status => :created, :location => @panchayat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @panchayat.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @panchayat = Panchayat.find(params[:id])

    respond_to do |format|
      if @panchayat.update_attributes(params[:panchayat])
        format.html { redirect_to(@panchayat, :notice => 'Panchayat was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @panchayat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panchayats/1
  # DELETE /panchayats/1.xml
  def destroy
    @panchayat = Panchayat.find(params[:id])
    @panchayat.destroy

    respond_to do |format|
      format.html { redirect_to(panchayats_url) }
      format.xml  { head :ok }
    end
  end
  def load_districts
    @load_districts = District.where(:division_id => params[:id]).order("name ASC")
    respond_to do |format|
      format.js
    end
  end
  def load_blocks
    @load_blocks = Block.where(:district_id => params[:id]).order("name ASC")
    respond_to do |format|
      format.js
    end
  end

end
