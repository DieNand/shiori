# frozen_string_literal: true

require_relative "Shiori/version"
Dotenv.load

module Shiori
  class Error < StandardError; end
  
  def self.version
    puts "Running Shiori version: #{VERSION}"
  end

  def self.run_shiori_bot
    Bots::Shiori.run
  end
end