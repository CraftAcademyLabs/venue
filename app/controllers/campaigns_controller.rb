class CampaignsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    if user_signed_in? && current_user.admin?
      @campaigns = Campaign.all
    else
      @campaigns = Campaign.with_state(:accepted)
    end
  end

  def new
    @campaign = Campaign.new
    authorize @campaign
  end

  def create
    @campaign = current_user.campaigns.create(campaign_params)
    if @campaign.persisted?
      @ticket = @campaign.tickets.create(ticket_params[:tickets_attributes]['0'])
      flash[:notice] = 'Campaign successfully launched'
      redirect_to campaign_path(@campaign)
    else
      render json: {message: 'Additional input required'}, status: 422
    end
  end

  def campaign_tickets
    [@tickets, @campaign]
  end

  def campaign_tickets_attributes=(attributes)
  end
  
  def show
    @campaign = Campaign.find(params[:id])
  end

  def update
    state_transitions
  end

private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :location, :image, :state)
  end

  def ticket_params 
    params.require(:campaign).permit(tickets_attributes: [:id, :price, :name])
  end

  def state_transitions
    campaign = Campaign.find(params[:id])
    if params[:event] == 'accept'
      campaign.accept
      redirect_to campaigns_path, notice: 'This campaign is now live!'
    elsif
      params[:event] == 'archive'
      campaign.archive
      redirect_to campaigns_path, notice: 'Campaign has been archived'
    end
  end
end
