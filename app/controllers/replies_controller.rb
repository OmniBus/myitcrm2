class RepliesController < ApplicationController
	load_and_authorize_resource
  # GET /replies
  # GET /replies.xml
  def index
    @replies = Reply.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @replies }
    end
  end

  # GET /replies/1
  # GET /replies/1.xml
  def show
    @reply = Reply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reply }
    end
  end

  # GET /replies/new
  # GET /replies/new.xml
  def new
    @reply = Reply.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reply }
    end
  end

  # GET /replies/1/edit
  def edit
    @reply = Reply.find(params[:id])
  end

  # POST /replies
  # POST /replies.xml
  def create
    if can? :create, Reply
      @reply = Reply.new(params[:reply])
      @reply.work_order_id = params[:id]
      @reply.user_id = current_user.id
      @reply.dynamic_attributes[:private] if current_user.employee
    end
    respond_to do |format|
      if @reply.save
        format.html { redirect_to( :back, :notice => 'Reply was successfully created.') }
        format.xml  { render :xml => @reply, :status => :created, :location => @reply }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /replies/1
  # PUT /replies/1.xml
  def update
    if can? :update, Reply
      @reply = Reply.find(params[:id])
      @reply.work_order_id = params[:id]
      @reply.user_id = current_user.id
      @reply.dynamic_attributes[:private] if current_user.employee
    end
    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        format.html { redirect_to( work_order_path(@reply.work_order_id), :notice => 'Reply was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.xml
  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy

    respond_to do |format|
      format.html { redirect_to(:back, :notice => 'Reply was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
