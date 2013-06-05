class MembersController < ApplicationController
  # user must be logged in to get to inventory info
  #before_filter :authenticate_user!

  def index
	  @members = Member.all
  end

  def new
    if params[:from].nil?
      if params[:id].nil?
        @member = Member.new
      else
        @member = member.find(params[:id])
      end
    else
      @member = member.new
      if params[:from] == "almost_out" 
        @member.customer_id = params[:customer_id]
        @member.item_id = params[:item_id]
      end
    end
  end

  def edit
    @member = member.find(params[:id])
  end

  def create
    @member = member.new(params[:member])
    if @member.save
      # if saved to database
      flash[:notice] = "Successfully #{@member.name} to system."
      if params[:from].nil?
        redirect_to members_url
      else
        redirect_to :back
      end
    else
      # return to the 'new' form
      render :action => 'new'
    end
  end

  def update
    @member = member.find(params[:id])
    authorize! :update, @member
    if @member.update_attributes(params[:member])
      flash[:notice] = "Successfully updated #{@member.name}."
      redirect_to members_url
    else
      render :action => 'edit'
    end
  end

  def destroy
    @member = member.find(params[:id])
    @member.destroy
    flash[:notice] = "Successfully removed #{@member.name} from your list."
    redirect_to members_url
  end
end