module Agenda
  class Agenda
    attr_accessor :events

    def initialize(events: [])
      @events = events
    end

    def has_event?(event)
      @events.find(event)
    end

    def add_event(event)
      existing = @events.index(event)

      if existing.nil?
        @events << event
      else
        @events[existing].attendees = @events[existing].attendees + event.attendees
      end

      sort!
    end

    def sort!
      @events = @events.sort_by { |event| event.dtstart.to_time }
    end

    def to_s
      "Tidspunkt\tDeltager(e)\tBegivenhed\n" +
      @events.map(&:to_s).join("\n")
    end
  end
end
