# -*- coding: utf-8 -*-
require_relative "../model/server"

module Plugin::Mattermost
	class Team < Diva::Model

		register :mattermost_team, name: "Mattermost Team"

		field.string	:id, required: true
		field.string	:name
		field.string	:display_name

		def channels
			# メソッド名的に、private/direct/groupも取得するべき
			api.channels.public_channels(self)
		end

		def perma_link
			Diva::URI("#{api.server_url}/#{name}")
		end

		private

		def api
			self[:api]
		end
	end
end
