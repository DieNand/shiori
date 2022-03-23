# Shiori

Bot is used to search anilist or mal for a specific id and then post the result


# Build the bot

To build and run the bot, use the following commands

`gem uninstall Shiori` (Remove old version of the bot that may be installed)

`gem build Shiori.gemspec` (Make sure that Shiori-<version>.gem is not already present in main directory)

`gem install Shiori`

`shiori`

# Start bot for testing

Use this command to start the bot

`gem build Shiori.gemspec && gem install Shiori && bundle exec shiori`

The bot responds to the following commands

`!anilist_id <id-required>`
  
`!mal_id <id-required>`
  
`!name <name-string-required>`


# Run on docker

To install docker on WSL use this link
https://docs.docker.com/engine/install/ubuntu/

To install docker compose on WSL use this link
https://docs.docker.com/compose/install/

Use this command to start docker on WSL (Windows). (systemd doesn't seem to work on WSL)
`sudo service docker start`

Build the image
`sudo docker-compose build`

Run the image
`sudo docker -D run shiori_web`

Run image and pass in Dicord bot_id
`sudo docker run --env BOT_ID='<bot-id-goes-here>' -d shiori_web`

Clean out old containers
`sudo docker system prune`

Save built Shiori image to .tar
`sudo docker save shiori_web -o shiori.tar`

Load Shiori image from .tar
`sudo docker image load -i ./shiori.tar`
  
# Contributions

Contributions are welcome. To contribute, fork the repo and create a pull request
