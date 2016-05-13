class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :archive]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.where.not(state: :archived).order('created_at DESC')
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message.read if @message.unread?
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_url, notice: 'Mensagem criada.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Mensagem atualizada.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def archive
    @message.archive
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Mensagem removida.' }
      format.json { head :ok }
    end
  end


  # POST /messages/archive_all
  # POST /messages/archive_all
  def archive_all
    Message.archive_all!
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Mensagens removidas.' }
      format.json { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :content)
    end
end
