# basic anilist GraphQL implementation
class Anilist
	def search_with_anilist_id(id:)
		vars = variables(id: id, type: 'id')
		search(vars: vars)
	end

	def search_with_id_mal(id_mal:)
		vars = variables(id: id_mal, type: 'idMal')
		search(vars: vars)
	end

	def search_with_anime_name(name:)
		vars = variables(id: name, type: 'search')
		search(vars: vars)
	end

	def search(vars:)
		options = {
			body: {
				query: query(variables: vars),
				variables: vars
			}
		}
		
		return HTTParty.post('https://graphql.anilist.co', options)
	end
	
	private
	def query(variables:)
	query_id = variables.keys[0].to_s
	variable_type = if variables[query_id.to_sym].is_a? Integer
					'Int'
				 elsif variables[query_id.to_sym].is_a? String
					'String'
				 end
	# set default value like so
	# query ($#{query_id}: Int = 15125) {
	<<-QUERY
	query ($#{query_id}: #{variable_type}) {
		Media (#{query_id}: $#{query_id}, type: ANIME) {
			id
			idMal
			siteUrl
			title {
				romaji
				english
				native
			}
      externalLinks {
        id
				url
				site
      }
    	streamingEpisodes {
        site
        title
        thumbnail
        url
      }
		}
	}
	QUERY
	end

	def variables(id:, type:)
		{"#{type}": id}
	end
end
