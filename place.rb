require 'net/http'
require 'uri'
require 'nokogiri'

class Place
  attr_reader :place
  def initialize(place)
    @place = place
  end

  def request
    url = place[:url]
    uri = URI.parse(url)
    request = Net::HTTP::Get.new(uri)
    request["Connection"] = "keep-alive"
    request["Cache-Control"] = "max-age=0"
    request["Upgrade-Insecure-Requests"] = "1"
    request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"
    request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"
    request["Accept-Language"] = "ko,en-US;q=0.9,en;q=0.8,ja;q=0.7,es;q=0.6"
    request["Cookie"] = "_ga=GA1.2.299807075.1542114254; NID_AUT=RYGpv2cV89C4BcmJ1g5pMTt+w7FKgDmHxsvO++KiiOg0MWspevtrkRD3QZtIyUeq; NID_SES=AAABpoUZNonG9oWGnmkloWvC8kwzuWs14ArqkYPALNjoWXc7ZeM9M6oeFK5UOSPGbZh8GZVfnyDwIyXEGXQsTgGTHbUJOQ4UEcK5Sw05NRiHhmSHeUZLWqE4VhUV0QhjSXVnt3/wB7EdtHSYIP5CKnJa5lmWZOAFltcv3UUXc2KazJ+F4MFj4x2auCBprTAzlkYRgogO6247FjWYsOkhqUOfFMKp3pyMu03S5nVmwlXV0dvCxNgF9YFnKgbpuBkJjkPBg4+TDckNFYUgITr8LbeYUAsyXH2txIVBC2CmsTInaWxup9uuwhS1dX2+3/sK3iJc58icc4SNMGxePJMseiomJC+rhIrA/fWh8aJV7TLzh4NQd+HymHABWRfrj0w/Y2+keHia2/P8it1fvKgC0diyGhX3stAvNDBqoJwf/lVqvS2iEtwa8vb67kbcsFVJUKya8LJuezF+a32v+jcQT4YmaHOXoZa/q3wXmJVLKxKRvMzQW8LLErpaaLweqw1JFB247Iudq6Lo1T24Wvb4vdKijo8pgAXxWZNk8R78pVi2n0RAHXj3XKCSpowjf/QfH5boHg==; _gid=GA1.2.1707587280.1546705342; wcs_bt=b942b9bd976724:1546707789"

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

  def reserv_list
    doc = Nokogiri::HTML(request.body)
    doc.css('.reserv_list').first.css('.lst')
  end

  def rooms
    contents = []
    reserv_list.each do |list|
      title = list.css('.flex label').text
      value = list['_productid']
      reserve_url = "https://spacecloud.kr/reserve/#{place[:value]}/#{value}"
      attribute = { title: title, value: value, url: reserve_url }
      contents << attribute if value
    end
    contents
  end
end
