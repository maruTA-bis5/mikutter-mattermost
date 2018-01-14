# -*- coding: utf-8 -*-
require_relative "../model/team"

module Plugin::Mattermost
	class Channel < Diva::Model
		include Diva::Model::MessageMixin
		include Diva::Model::UserMixin

		register :mattermost_channel, name: "Channel"

		field.string	:id, required: true
		field.string	:name, required: true
		field.string	:display_name, required: true
		field.time	:create_at
		field.has :team, Plugin::Mattermost::Team, required: true
		field.string	:type, required: true

		def icon
			Enumerator.new{|y| Plugin.filtering(:photo_filter, "#{team.server.url}/favicon.ico", y)}.first
		end

		def idname
			name
		end

		def user
			self
		end

		def description
			display_name
		end

		def datasource_slug
			:"mattermost_#{team.id}_#{id}"
		end

		def datasource_name
			["mattermost", team.name, display_name]
		end

		def perma_link
			Diva::URI("#{team.server.url}/#{team.name}/#{name}")
		end
	end
end
