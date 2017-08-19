class User::RegistrationForm
  include ActiveModel::Model
  # include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :user, :name, :age, :addresses, :addresses_attributes, :post_images, :post_images_attributes, :uploaded_files

  validates :name, presence: true

  before_validation :save_image

  def initialize(user_params = {})
    @name ||= user_params['name']
    @age ||= user_params['age']

    default_addresses = [Address.new(kind_id: 'home', prefecture_id: 13), Address.new(kind_id: 'office', prefecture_id: 13)]
    @addresses = if user_params.has_key?(:addresses_attributes)
      addresses = []
      user_params[:addresses_attributes].to_h.keys.each.with_index do |key, index|
        municipality = user_params[:addresses_attributes].to_h[key]['municipality']
        addresses << Address.new(user_params[:addresses_attributes].to_h[key]) unless municipality.blank?
      end
      if addresses.size == 0
        addresses = default_addresses
      elsif addresses.size == 1
        addresses << default_addresses.first
      end
      addresses
    else
      default_addresses
    end

    default_post_image_count = 3
    default_post_images = default_post_image_count.times.map{ PostImage.new() }
    @post_images = if user_params.has_key?(:post_images_attributes)
      images = []
      user_params[:post_images_attributes].to_h.keys.each.with_index do |key, index|
        if user_params[:post_images_attributes].to_h[key]['file_name'].present?
          file_name = user_params[:post_images_attributes].to_h[key]['file_name'].original_filename
          file_path = PostImage::PUBLIC_IMAGE_PATH + file_name
          images << PostImage.new( file_name: file_name, file_path: file_path )
        end

        if user_params[:post_images_attributes].to_h[key]['file_path'].present?
          file_path = user_params[:post_images_attributes].to_h[key]['file_path']
          file_name = file_path.gsub(PostImage::PUBLIC_IMAGE_PATH, '')
          images << PostImage.new( file_name: file_name, file_path: file_path )
        end
      end

      if default_post_image_count > images.size
        (default_post_image_count - images.size).times do
          images << PostImage.new()
        end
      end
      images
    else
      default_post_images
    end

    @uploaded_files = if user_params.has_key?(:post_images_attributes)
      uploaded_files = []
      user_params[:post_images_attributes].to_h.keys.each.with_index do |key, index|
        if user_params[:post_images_attributes].to_h[key]['file_name'].present?
          uploaded_files << user_params[:post_images_attributes].to_h[key]['file_name']
        end
      end
      uploaded_files
    end
  end

  def save_image
    if @uploaded_files.present?
      @uploaded_files.each.with_index do |upload_image, index|
        output_path = Rails.root.join('public' + PostImage::PUBLIC_IMAGE_PATH, upload_image.original_filename)
        File.open(output_path, 'w+b') do |fp|
          fp.write  upload_image.read
        end
      end
    end
  end

  def save
    return false if invalid?
    @user = User.new(name: name, age: age)
    @user.addresses = @addresses
    @user.post_images = @post_images.reject{ |image| image.invalid? }
    @user.save!
    true
  end

end