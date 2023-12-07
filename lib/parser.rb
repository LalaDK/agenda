#!/usr/bin/env ruby

require 'uri'
require 'date'
require 'net/http'
require './agenda'
require 'icalendar/recurrence'

DATE_FROM = Date.today
DATE_TO = Date.today + 1.day
agenda = Agenda.new

File.readlines('./calendars', chomp: true).each do |line|
  name, url = line.split('|')
  uri = URI(url)
  response = Net::HTTP.get_response(uri)
  data = response.body if response.is_a?(Net::HTTPSuccess)
  data = data.gsub('W. Europe Standard Time', 'Europe/Copenhagen')
  calendars = Icalendar::Calendar.parse(data)
  calendars.each do |calendar|
    recurring_events = calendar.events.select { |event| !event.rrule.empty? }
    recurring_events.each do |r_event|
      r_event.occurrences_between(DATE_FROM, DATE_TO).each do |occurence|
        e = Event.new(
          attendees: [name],
          dtstart: occurence.start_time.getlocal,
          dtend: occurence.end_time.getlocal,
          summary: r_event.summary
        )
        agenda.add_event(e)
      end
    end

    events = calendar.events.select { |event| event.rrule.empty? && event.dtstart >= DATE_FROM && event.dtend <= DATE_TO }
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

puts agenda
