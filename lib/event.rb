class Event
  attr_accessor :dtstart, :dtend, :allday, :summary, :attendees

  def initialize(dtstart: nil, dtend: nil, allday: false, summary: nil, attendees: [])
    @dtstart = dtstart
    @dtend = dtend
    @allday = allday
    @summary = summary
    @attendees = attendees
  end

  def ==(obj)
    @dtstart.strftime("%Y-%m-%d %H:%M:%S") == obj.dtstart.strftime("%Y-%m-%d %H:%M:%S") &&
    @dtend.strftime("%Y-%m-%d %H:%M:%S") == obj.dtend.strftime("%Y-%m-%d %H:%M:%S") &&
    @summary == obj.summary
  end

  def to_s
    if @allday
    "#{@dtstart.strftime('%d/%m-%Y')}\tHele dagen\t#{ @summary }\t#{attendees.join(', ')}"
    else
    "#{@dtstart.strftime('%d/%m-%Y')}\t#{ @dtstart.strftime('%H:%M') }-#{ @dtend.strftime('%H:%M') }\t#{ @summary }\t#{attendees.join(', ')}"
    end
  end
end
