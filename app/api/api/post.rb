module API
	class Post < Grape::API
	  use Rack::JSONP
	  include Grape::Kaminari

		resource :post_data do

			desc "get Post collection by a given page"

			paginate per_page: 10
			get do 
				 posts = PostDatum.order('age DESC', 'like ASC')
    	   paginate(posts)
			end

			desc "Performs a search on Instagram by a given a tag and stores the result in the DB"

			params do
				requires :tag , type: String
			end

			post '/search' do
					
				response = Instagram.tag_recent_media(params[:tag])

				response.each do |media|

					if !PostDatum.exists?(:socialId => media["id"])
						PostDatum.create!({
						 	socialId: media["id"],
					    name: media["link"],
					    origin: "Instagram",
					    age: media['created_time'],
					    body: media['caption']['text'],
					    like: 0,
					    unlike: 0,
					    image_url: media['images']['standard_resolution']['url']
				  	})
					else
						puts "post exists"
					end	 
				end
				PostDatum.all
			end

			desc "Retrieves a list of tags by a given query"
			params do
				requires :tagName, type:String
			end
			get '/tags' do
				response = Instagram.tag_search(params[:tagName])
				
			end
			
			desc "upvote a post"
			
			params do
				requires :postId, type: Integer
			end
			post '/like' do
				post = PostDatum.find_by(id: params[:postId])
				post.like = post.like + 1
				post.save
				post
			end

			desc "downvote a post"
			
			params do
				requires :postId, type: Integer
			end
			post '/unlike' do
				post = PostDatum.find_by(id: params[:postId])

				post.unlike = post.unlike + 1
				post.save
				post
			end
			
			desc "shows Instagram API limit"
			get '/limits' do
				response = Instagram.utils_raw_response
				
			end
		end

		resource :post_crawler do

			get '/crawler' do
				# Anemone.crawl("http://ohdios.org/", :depth_limit => 5) do |anemone|
				# 	images = []
				#   anemone.on_every_page do |page|
				#     page.doc.xpath('//img').each do |link|
				#       process_dependency(page, link[:src])
				#     end
				#   end
				#   images
			end
		end

		resource :slack_bot do
			post '/post' do
				params
			end
		end
	end
end
	