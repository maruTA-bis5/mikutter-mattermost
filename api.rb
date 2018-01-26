require_relative 'api/teams'
require_relative 'api/channels'
require_relative 'api/users'

module Plugin::Mattermost
	module API
		class Wrap
			def initialize(client)
				@client = client
			end
	
			def start_poll
				api = self
				@ws = @client.connect_websocket do |ws|
					ws.on :posted do |event|
						data = event["data"]
						post = JSON.parse data["post"]
						channel_id = post["channel_id"]
						user_id = post["user_id"]
						notice "channel_id: #{channel_id}, user_id: #{user_id}, post: #{post}"

						Delayer::Deferred.when(
							api.channels.channel(channel_id),
							api.users.user(user_id)
						).next{|channel, user|
							notice "in next{}"
							notice "channel: #{channel}, user: #{user}"
							msg = Plugin::Mattermost::Post.new(
								id: post["id"],
								message: post["message"],
								user: user,
								channel: channel,
								create_at: post["create_at"] / 1000
							)
							notice msg
							Plugin.call(:extract_receive_message, channel.datasource_slug, [msg])
						}.trap{ |err| error err }
					end
				end
			end
	
			def teams
				@teams ||= Plugin::Mattermost::API::Teams.new self
			end

			def channels
				@channels ||= Plugin::Mattermost::API::Channels.new self
			end

			def users
				@users ||= Plugin::Mattermost::API::Users.new self
			end

			def client
				@client
			end

			def server_url
				client.server
			end
		end
	end
end
