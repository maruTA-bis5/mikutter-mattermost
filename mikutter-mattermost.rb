# -*- coding: utf-8 -*-
require_relative "world"
require "mattermost"
Plugin.create(:mikutter_mattermost) do

	world_setting(:mattermost, _("Mattermost")) {
		label(_("MattermostのURLと、認証に用いるパーソナルアクセストークンを入力してください"))

		input(_("URL"), :server_url)
		input(_("Personal Access Token"), :access_token)

		result = await_input

		world = Plugin::Mattermost::World.new(result.to_h)
		world
	}

	filter_extract_datasources do |ds|
		Enumerator.new{|y|
			Plugin.filtering(:worlds, y)
		}.select{|world|
			notice world.class.slug
			notice world.class.slug == :mattermost
			world.class.slug == :mattermost
		}.each{|world|
			world.teams().each { |team|
				team.channels().each { |channel| ds[channel.datasource_slug] = channel.datasource_name }
			}
		}
		[ds]
	end
end
