# -*- coding: utf-8 -*-

module Plugin::Mattermost
	class Server < Diva::Model

		register :mattermost_server, name: "Mattermost Server"

		field.string	:url, required: true

		def initialize(server_url, world)
			url = server_url
		end

		def teams
			# TODO
			[]
		end
	end
end
