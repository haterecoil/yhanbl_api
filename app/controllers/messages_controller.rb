class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [:show, :update, :destroy]


  # GET /messages
  # GET /messages.json
  def index
    @messages = policy_scope(Message)

    render json: @messages
  end

  # GET /messages/new
  # GET /messages/new.json
  def get_new_messages
    @messages = policy_scope(Message);

    @messages = @messages.select do |om|
      om.read_on.nil?
    end

    render json: @messages
  end

  # PUT /messages/set_read_date
  def set_read_messages
    obj = params["read_messages"]

    if (obj.class != Array)
      render json: obj, status: :bad_request
      return
    end

    messages = [];

    obj.each do |id|
      message = Message.find(id);
      authorize message
      message.read_on = DateTime.now

      if message.save!
        messages.push(message)
      else
        render json: message.errors, status: :internal_server_error
        return
      end
    end

    render json: @messages, status: :accepted
  end


  # GET /messages/1
  # GET /messages/1.json
  def show
    authorize @message
    render json: @message
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(upload_params)
    @message.sender = @current_user

    authorize @message

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    authorize @message

    if @message.update(message_params)
      head :no_content
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    authorize @message
    @message.destroy

    head :no_content
  end

  private

    def pundit_user
      @current_user
    end

    def set_message
      @message = Message.find(params[:id])
    end

    def message_params
      params.permit(:title, :text)
    end

    def upload_params
      the_params = params.permit(:picture, :title, :text, :recipient_id)
      if (!the_params[:picture].nil?)
        the_params[:picture] = parse_image_data(the_params[:picture]) if the_params[:picture]
      end

      the_params
    end

    def parse_image_data(base64_image)
      filename = "upload-image"
      in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]

      @tempfile = Tempfile.new(filename)
      @tempfile.binmode
      @tempfile.write Base64.decode64(string)
      @tempfile.rewind

      # for security we want the actual content type, not just what was passed in
      content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]

      # we will also add the extension ourselves based on the above
      # if it's not gif/jpeg/png, it will fail the validation in the upload model
      extension = content_type.match(/gif|jpeg|png|jpg/).to_s
      filename += ".#{extension}" if extension

      ActionDispatch::Http::UploadedFile.new({
        tempfile: @tempfile,
        content_type: content_type,
        filename: filename
      })
    end

    def clean_tempfile
      if @tempfile
        @tempfile.close
        @tempfile.unlink
      end
    end
end



