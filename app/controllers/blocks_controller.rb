class BlocksController < ApplicationController
  def index
    @blocks = Block.order("district_id ASC,name ASC").search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @blocks }
    end
  end

  def show
    @block = Block.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @block }
    end
  end

  def new
    @block = Block.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @block }
    end
  end

  def edit
    @block = Block.find(params[:id])
  end

  def create
    @block = Block.new(params[:block])

    respond_to do |format|
      if @block.save
        format.html { redirect_to(blocks_url, :notice => 'Block was successfully created.') }
        format.xml { render :xml => @block, :status => :created, :location => @block }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @block.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @block = Block.find(params[:id])

    respond_to do |format|
      if @block.update_attributes(params[:block])
        format.html { redirect_to(@block, :notice => 'Block was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @block.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @block = Block.find(params[:id])
    @block.destroy

    respond_to do |format|
      format.html { redirect_to(blocks_url) }
      format.xml { head :ok }
    end
  end

  def load_districts
    @load_districts = District.where(:division_id => params[:id]).order("name ASC")
    respond_to do |format|
      format.js
    end
  end

end
