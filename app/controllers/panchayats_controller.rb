class PanchayatsController < ApplicationController
  # GET /panchayats
  # GET /panchayats.xml
  def index
    @panchayats = Panchayat.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @panchayats }
    end
  end

  # GET /panchayats/1
  # GET /panchayats/1.xml
  def show
    @panchayat = Panchayat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @panchayat }
    end
  end

  # GET /panchayats/new
  # GET /panchayats/new.xml
  def new
    @panchayat = Panchayat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @panchayat }
    end
  end

  # GET /panchayats/1/edit
  def edit
    @panchayat = Panchayat.find(params[:id])
  end

  # POST /panchayats
  # POST /panchayats.xml
  def create
    @panchayat = Panchayat.new(params[:panchayat])

    respond_to do |format|
      if @panchayat.save
        format.html { redirect_to(@panchayat, :notice => 'Panchayat was successfully created.') }
        format.xml  { render :xml => @panchayat, :status => :created, :location => @panchayat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @panchayat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panchayats/1
  # PUT /panchayats/1.xml
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
end
