class User < ActiveRecord::Base
  has_many :idol_users
  has_many :idols, through: :idol_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable,
         :omniauthable, omniauth_providers: [:twitter, :facebook]

  validates :username, presence: true

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        username: auth.info.name,
        email: User.get_email(auth),
        password: Devise.friendly_token[4, 30])
    end
    user
  end

  private
    def self.get_email(auth)
      email = auth.info.email
      email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
    end

end
