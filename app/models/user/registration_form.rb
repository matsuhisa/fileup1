class User::RegistrationForm
  include ActiveModel::Model
  #include ActiveModel::Validations

  attr_accessor :user, :name, :age, :addresses, :addresses_attributes, :post_images, :post_images_attributes, :uploaded_files

  validates :name, presence: true

  def initialize(user_params = {})
    @name ||= user_params['name']
    @age ||= user_params['age']

    @addresses = if user_params.has_key?(:addresses_attributes)
      addresses = []
      user_params[:addresses_attributes].to_h.keys.each.with_index do |key, index|
        municipality = user_params[:addresses_attributes].to_h[key]['municipality']
        addresses << Address.new(user_params[:addresses_attributes].to_h[key]) unless municipality.blank?
      end
      addresses
    else
      [Address.new(kind_id: 'home', prefecture_id: 13), Address.new(kind_id: 'office', prefecture_id: 13)]
    end

    @post_images = if user_params.has_key?(:post_images_attributes)
      images = []
      user_params[:post_images_attributes].to_h.keys.each.with_index do |key, index|
        images << PostImage.new( file_name: user_params[:post_images_attributes].to_h[key]['file_name'].original_filename )
      end
      images
    else
      3.times.map{ PostImage.new() }
    end

    @uploaded_files = if user_params.has_key?(:post_images_attributes)
      uploaded_files = []
      user_params[:post_images_attributes].to_h.keys.each.with_index do |key, index|
        uploaded_files << user_params[:post_images_attributes].to_h[key]['file_name']
      end
      uploaded_files
    end
  end

  def save
    return false if invalid?

    @user = User.new(name: name, age: age)
    @user.addresses = @addresses
    @user.post_images = @post_images
    unless @uploaded_files.nil?
      @uploaded_files.each.with_index do |upload_image, index|
        output_path = Rails.root.join('public', upload_image.original_filename)
        File.open(output_path, 'w+b') do |fp|
          fp.write  upload_image.read
        end
      end
    end
    @user.save!

    true
  end

end