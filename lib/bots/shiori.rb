require 'byebug'

module Bots
  class Shiori
    def self.run
      bot = Discordrb::Commands::CommandBot.new token: ENV['BOT_ID'], prefix: '!'

      bot.command(:ani_lookup) do |event, id|
        result = Anilist.new().search_with_anilist_id(id: id.to_i)
        event.respond JSON.parse(result.to_s)['data']['Media']['siteUrl']
      end

      bot.command(:mal_lookup) do |event, id|
        result = Anilist.new().search_with_id_mal(id_mal: id.to_i)
        event.respond "https://myanimelist.net/anime/#{JSON.parse(result.to_s)['data']['Media']['idMal']}"
      end

      bot.run
    end
  end
end