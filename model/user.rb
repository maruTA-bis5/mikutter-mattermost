# -*- coding: utf-8 -*-
require_relative "../model/server"

module Plugin::Mattermost
	class User < Diva::Model
		include Diva::Model::UserMixin

		field.string	:id, required: true
		field.string	:username, required: true
		field.string	:first_name
		field.string	:last_name
		field.string	:nickname

		def inspect
			"#<#{self.class}: #{id} #{username} #{first_name} #{last_name} #{nickname}>"
		end

		def idname
			username
		end

		def title
			if first_name == "" && last_name == "" && nickname == "" 
				idname
			end
			if first_name != "" && last_name == ""
			  t = first_name
			elsif first_name == "" && last_name != ""
			  t = last_name
		 	else
				t = "#{first_name} #{last_name}"
			end
			if nickname != ""
				t = "#{t}(#{nickname})"
			end
			t
		end
		alias name title

		def icon
			# FIXME photosupport/photo/openimgでは開くときにAuthヘッダーをつけないので401になる
			# TODO Mattermost::Clientの代わりにPlugin::Mattermost::API::Usersを使う
			#_, photos = Plugin.filtering(:photo_filter, "#{@client.base_uri}#{@client.get_user_profile_image_url(id)}", [])
			#notice photos
			#notice @client.class.headers
			#photos.first
		#rescue => err
			#warn err
			Skin['notfound.png']
		end

		#def perma_link
			# TODO <server_url>/<team name>/messages/@<username>
			#Diva::URI("#{api.server_url}/messages/@#{username}")
		#end

		def to_s
			username
		end

		private

		def api
			self[:api]
		end
	end
end
