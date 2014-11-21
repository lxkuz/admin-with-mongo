class User
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include Searchable

  scope :by_email, -> order { order_by email: order }

  devise :database_authenticatable, :registerable, :rememberable, :validatable

  field :email, default: ''
  field :encrypted_password, default: ''
  field :remember_created_at, type: DateTime

  settings index: {} do
    mappings dynamic: 'false' do
      indexes :email
    end
  end

  def to_key
    key = super
    key = key.map(&:to_s) if key
    key
  end
end
