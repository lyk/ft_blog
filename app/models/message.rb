class Message < ApplicationRecord
	validates :title, length: {minimum: 5}, presence: true
	validates :content, length: {minimum: 15}, presence: true
end
