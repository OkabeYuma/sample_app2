class Micropost < ActiveRecord::Base
    belongs_to :user
    default_scope -> { order('created_at DESC')}
    variables :content, presence: true, length: { maximum: 140 }
    variables :user_id, presence: true
end
