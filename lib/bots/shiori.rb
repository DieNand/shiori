require 'byebug'

module Bots
  class Shiori
    def self.run
      bot = Discordrb::Commands::CommandBot.new name: 'Shiori',
                                                token: ENV['BOT_ID'], 
                                                prefix: '!'

      bot.command(:anilist_id, 
                  description: 'Uses provided anilist_id to lookup anime on anilist eg. `!anilist_id <anilist_id>`') do |event, id|
        result = Anilist.new().search_with_anilist_id(id: id.to_i)
        event.respond JSON.parse(result.to_s)['data']['Media']['siteUrl']
      end

      bot.command(:mal_id,
                  description: 'Uses provided mal_id to lookup anime on anilist eg. `!mal_id <mal_id>`') do |event, id|
        result = Anilist.new().search_with_id_mal(id_mal: id.to_i)
        event.respond "https://myanimelist.net/anime/#{JSON.parse(result.to_s)['data']['Media']['idMal']}"
      end

      bot.command(:anime,
                  description: 'Searches for anime on anilist using the romaji, native or english name eg. `!anime <name_of_anime_typed_out>`') do |event|
        name = event.message.content.gsub("!anime", '').strip
        result = Anilist.new().search_with_anime_name(name: name)
        event.respond "https://myanimelist.net/anime/#{JSON.parse(result.to_s)['data']['Media']['idMal']}"
      end

      bot.message(contains: /(\d+)/) do |event|
        search_ids = event.message.content.scan(/(\d+)/).flatten
        search_ids.each do |mal_id|
          result = Anilist.new().search_with_id_mal(id_mal: mal_id.to_i)
          event.respond "https://myanimelist.net/anime/#{JSON.parse(result.to_s)['data']['Media']['idMal']}"
        end
      end

      bot.run
    end
  end
end