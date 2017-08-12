class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new

    3.times do ||
      @user.post_images << PostImage.new()
    end

    @user.addresses << home_address = Address.new(kind_id: 'home')
    @user.addresses << office_address = Address.new(kind_id: 'office')
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.addresses = @user.addresses.reject { |item| item.municipality.blank? }

    user_params[:post_images_attributes].to_h.keys.each.with_index do |key, index|
      upload_image = user_params[:post_images_attributes].to_h[key]['file_name']
      output_path = Rails.root.join('public', upload_image.original_filename)
      File.open(output_path, 'w+b') do |fp|
        fp.write  upload_image.read
      end
      @user.post_images[index].file_name = upload_image.original_filename
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.addresses = @user.addresses.reject { |item| item.municipality.blank? }
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :name, :age, 
        addresses_attributes: [:id, :municipality, :prefecture_id, :kind_id],
        post_images_attributes: [:id, :file_name]
      )
    end
end
