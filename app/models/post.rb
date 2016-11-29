class Post < ApplicationRecord
	validates_presence_of :title, :article

	belongs_to :user
end
