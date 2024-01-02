module Agenda
  class Parser
    require 'icalendar/recurrence'
    require 'date'
    require 'yaml'

    def self.calendar_configs(config_file: "#{Dir.home}/.config/agenda/config.yaml")
      yaml = YAML.load_file(config_file)
      result = yaml['calendars'].map do |calendar|
        [
          calendar['name'],
          calendar['url']
        ]
      end

      yield result if block_given?

      result
    end

    def self.parse_calendars
      agenda = ::Agenda::Agenda.new

      date_from = Date.today
      date_to = Date.today + 1.day

      calendar_configs.each do |name, url|
        data = ::Agenda::Http.fetch(url: url)
        data = data.gsub('W. Europe Standard Time', 'Europe/Copenhagen')
        calendars = Icalendar::Calendar.parse(data)
        calendars.each do |calendar|
          recurring_events = calendar.events.select { |event| !event.rrule.empty? }
          recurring_events.each do |r_event|
            r_event.occurrences_between(date_from, date_to).each do |occurence|
              e = Event.new(
                attendees: [name],
                dtstart: occurence.start_time.getlocal,
                dtend: occurence.end_time.getlocal,
                summary: r_event.summary
              )
              agenda.add_event(e)
            end
          end

          events = calendar.events.select { |event| event.rrule.empty? && event.dtstart >= date_from && event.dtend <= date_to }
          events.each do |event|
            e = Event.new(
              attendees: [name],
              dtstart: event.dtstart,
              dtend: event.dtend,
              summary: event.summary,
              allday: event.dtstart.is_a?(Icalendar::Values::Date)
            )
            agenda.add_event(e)
          end
        end
      end

      agenda
    end
  end
end
