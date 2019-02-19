require './places'
require './place'
require './reserve'

class FindRoom
  attr_reader :date
  def initialize()
    @date = '20190219'
  end

  def find
    places = Places.new.space_contents
    places.each do |p|
      puts p
      place = Place.new(p)
      place.rooms.each do |room|
        puts room
        reserve = Reserve.new(room, date)
        pp reserve.schedule_empty?
      end
    end
  end

  def debug
    room = {:title=>"프라이빗 멀티 - 낮 종일요금제", :value=>"15196", :url=>"https://spacecloud.kr/reserve/10063/15196"}
    reserve = Reserve.new(room, date)
    pp reserve.schedule_empty?
  end
end
FindRoom.new.find
# FindRoom.new.debug
