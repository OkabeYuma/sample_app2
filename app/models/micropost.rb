class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  has_attached_file :image, styles: { medium: "200x150>", thumb: "50x50>" }

  #拡張子の制限
  validates_attachment_content_type :image,
    :content_type => ['image/jpg', 'image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png'],
    :message => "JPG, GIF, PNGのみアップロードできます"
    
  #ファイルサイズの制限
  validates_attachment_size :image,
    :less_than => 2.megabytes,
    :message => "ファイルサイズが大きすぎます(最大2MBまで)"
    
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
