class EmailsController < ApplicationController
  before_action :set_email, only: %i[ show reply update destroy ]

  # GET /emails or /emails.json
  def index
    @emails = Email.where(to_email: Current.user.email_address)
    if params[:q].present?
      query = "%#{params[:q].downcase}%"
      @emails = @emails.where(
        "LOWER(subject) LIKE ? OR LOWER(from_email) LIKE ? OR LOWER(to_email) LIKE ?",
        query, query, query
      )
    end
  end

  # GET /emails/1 or /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @email = Email.new
  end

  # GET /emails/1/edit
  def reply
    @email = @email.dup
    @email.to_email = @email.from_email
    @email.from_email = Current.user.email_address
    @email.body = "\n\n___\n\n" + @email.body
  end

  # POST /emails or /emails.json
  def create
    sanitized_params = params.expect(email: [ :from_email, :to_email, :subject, :body ])
    sanitized_params[:from_email] = Array(sanitized_params[:from_email]).first if sanitized_params[:from_email].is_a?(Array)
    sanitized_params[:to_email] = Array(sanitized_params[:to_email]).first if sanitized_params[:to_email].is_a?(Array)
    @email = Email.new(sanitized_params)

    respond_to do |format|
      if @email.save
        SendEmailJob.perform_later(@email.id)
        format.html { redirect_to @email, notice: "Email was successfully created." }
        format.json { render :show, status: :created, location: @email }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emails/1 or /emails/1.json
  def update
    sanitized_params = params.expect(email: [ :from_email, :to_email, :subject, :body ])
    sanitized_params[:from_email] = Array(sanitized_params[:from_email]).first if sanitized_params[:from_email].is_a?(Array)
    sanitized_params[:to_email] = Array(sanitized_params[:to_email]).first if sanitized_params[:to_email].is_a?(Array)
    respond_to do |format|
      if @email.update(sanitized_params)
        format.html { redirect_to @email, notice: "Email was successfully updated." }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1 or /emails/1.json
  def destroy
    @email.destroy!

    respond_to do |format|
      format.html { redirect_to emails_path, status: :see_other, notice: "Email was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.expect(email: [ :from_email, :to_email, :subject, :body ])
    end
end
