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
    @user_register_form = User::RegistrationForm.new(user_params)
    @user_register_form.save_image
    if @user_register_form.invalid?
      render :new
    end
  end

  def create
    @user_register_form = User::RegistrationForm.new(user_params)
    if @user_register_form.save
      redirect_to complete_users_path
    else
      format.html { render :new }
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
