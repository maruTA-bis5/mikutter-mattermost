# -*- coding: utf-8 -*-
require_relative "../model/user"
require_relative "../model/channel"

module Plugin::Mattermost
	class Post < Diva::Model
		include Diva::Model::MessageMixin
	
		register :mattermost_post, name: "Post", timeline: true
	
		field.string	:message, required: true
		field.has	:user, Plugin::Mattermost::User, required: true
		field.has	:channel, Plugin::Mattermost::Channel, required: true
		field.time	:create_at
		field.time	:update_at
		field.time	:edit_at

		def description
			self.message
		end

		def created
			self.create_at
		end
	end

end

