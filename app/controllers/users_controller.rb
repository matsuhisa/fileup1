class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user_register_form = User::RegistrationForm.new
  end

  def edit
  end

  def create
    @user_register_form = User::RegistrationForm.new(user_params)

    respond_to do |format|
      if @user_register_form.save
        format.html { redirect_to @user_register_form.user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    # @user.addresses = @user.addresses.reject { |item| item.municipality.blank? }
    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { redirect_to @user, notice: 'User was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @user }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    # @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user_registration_form).permit(
        :name, :age, 
        addresses_attributes: [:id, :municipality, :prefecture_id, :kind_id],
        post_images_attributes: [:id, :file_name, :image_path]
      )
    end
end
