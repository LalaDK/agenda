module Agenda
  require_relative 'agenda/event'
  require_relative 'agenda/agenda'
  require_relative 'agenda/http'
  require_relative 'agenda/parser'

  def self.root
    File.dirname __dir__
  end
end
