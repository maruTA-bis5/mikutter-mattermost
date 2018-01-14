require_relative '../models'

module Plugin::Mattermost
	module API
		class Channels
	
			def initialize(api)
				@api = api
			end
	
			def public_channels(team)
				response = @api.client.get_public_channels(team.id, 65535)
				notice response
				raw_channels = response.parsed_response
				raw_channels.map{|channel|
					Plugin::Mattermost::Channel.new(channel.symbolize.merge(api: @api, team: team))
				}
			end

			def channel(channel_id)
				mmapi = @api
				Thread.new do
					response = mmapi.client.get_channel(channel_id)
					notice response
					raw_channel = response.parsed_response
					team_id = raw_channel["team_id"]
					team = mmapi.teams.get_team(team_id)
					channel = Plugin::Mattermost::Channel.new(raw_channel.symbolize.merge(api: mmapi, team: team))
					notice channel
					channel
				end
			end
		end
	end
end
