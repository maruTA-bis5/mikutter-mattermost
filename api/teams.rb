require_relative '../models'

module Plugin::Mattermost
	module API
		class Teams
	
			def initialize(api)
				@api = api 
			end
	
			def get_teams
				response = @api.client.get_teams
				notice response
				raw_teams = response.parsed_response
				raw_teams.map{|raw_team|
					Plugin::Mattermost::Team.new(raw_team.symbolize.merge(api: @api))
				}
			end

			def get_team(team_id)
				response = @api.client.get_team(team_id)
				notice response
				raw_team = response.parsed_response
				team = Plugin::Mattermost::Team.new(raw_team.symbolize.merge(api: @api))
				notice team
				team
			end
		end
	end
end
