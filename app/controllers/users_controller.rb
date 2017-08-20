class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user_register_form = User::RegistrationForm.new
  end

  def confirm
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

  def complete
  end

  def edit
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user_registration_form).permit(
        :name, :age, 
        addresses_attributes: [:id, :municipality, :prefecture_id, :kind_id],
        post_images_attributes: [:id, :file_name, :file_path]
      )
    end
end
