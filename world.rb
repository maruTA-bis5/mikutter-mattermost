# -*- coding: utf-8 -*-
require_relative 'api'
require_relative "model"
require 'mattermost'

module Plugin::Mattermost
	class World < Diva::Model

		register :mattermost, name: "Mattermost"

		field.string	:slug, required: true
		field.string	:access_token, required: true
		field.string	:server_url, required: true

		def initialize(hash)
			super(hash)
			self.merge(hash)
			user_refresh
			self.slug = "mattermost-#{server_url}"
			if @user != nil
				@api = Plugin::Mattermost::API::Wrap.new(@client)
				@api.start_poll
			end
		end

		def inspect
			"#<#{self.class}: #{server_url} #{slug}>"
		end

		def icon
			@user.icon
		end

		def title
			if @user != nil
				"#{@user.title} - #{server_url}"
			else
				"#{server_url}"
			end
		end

		def teams
			@api.teams.get_teams
		end

		private

		def user_refresh
			@client = Mattermost.new_client(server_url)
			@client.use_access_token(access_token)
			notice "connected?: #{@client.connected?}"
			@user = Plugin::Mattermost::User.new(@client.get_me.parsed_response.symbolize)
			Plugin.call(:world_modify, self)
		end
	end
end
