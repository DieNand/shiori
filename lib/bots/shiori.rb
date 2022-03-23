require 'byebug'

module Bots
  class Shiori
    def self.run
      bot = Discordrb::Commands::CommandBot.new name: 'Shiori',
                                                token: ENV['BOT_ID'], 
                                                prefix: '!'

      bot.command(:anilist_id) do |event, id|
        result = Anilist.new().search_with_anilist_id(id: id.to_i)
        event.respond JSON.parse(result.to_s)['data']['Media']['siteUrl']
      end

      bot.command(:mal_id) do |event, id|
        result = Anilist.new().search_with_id_mal(id_mal: id.to_i)
        event.respond "https://myanimelist.net/anime/#{JSON.parse(result.to_s)['data']['Media']['idMal']}"
      end

      bot.command(:anime) do |event, name|
        result = Anilist.new().search_with_anime_name(name: name)
        event.respond "https://myanimelist.net/anime/#{JSON.parse(result.to_s)['data']['Media']['idMal']}"
      end

      bot.command(:help) do |event, id|
        event.respond("**`help`**: Shows a list of all the commands available or displays help for a specific command.\n" \
                      "**`anilist_id`**: Provide an Anilist ID to lookup\n" \
                      "**`mal_id`**: Provide an MalID to lookup\n"\
                      "**`anime`**: Provide the name of an anime\n")
      end

      bot.run
    end
  end
end