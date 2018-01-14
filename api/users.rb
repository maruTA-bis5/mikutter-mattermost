# -*- coding: utf-8 -*-
require_relative '../models'

module Plugin::Mattermost
	module API
		class Users

			def initialize(api)
				@api = api 
			end

			def me
				response = @api.client.getMe
				notice respone
				raw_user = response.parsed_response
				Plugin::Mattermost::User.new(raw_user.symbolize.merge(api: mmapi))
			end

			def get_user_profile_image_url(id)
				notice @api.client.base_uri
				notice @api,client.class.base_uri
				"#{@api.client.base_uri}#{@api.client.get_user_profile_image_url(id)}"
			end

			def user(user_id)
				mmapi = @api
				Thread.new do
					response = mmapi.client.get_user(user_id)
					notice response
					raw_user = response.parsed_response
					user = Plugin::Mattermost::User.new(raw_user.symbolize.merge(api: mmapi))
					notice user
					user
				end
			end
		end
	end
end
