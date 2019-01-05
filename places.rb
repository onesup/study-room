require 'net/http'
require 'uri'
require 'nokogiri'

class Places
  def first_request
    uri = URI.parse("https://spacecloud.kr/search?q=%EC%8B%A0%EB%85%BC%ED%98%84%EC%97%AD%20%EC%8A%A4%ED%84%B0%EB%94%94%EB%A3%B8")
    request = Net::HTTP::Get.new(uri)
    request["Connection"] = "keep-alive"
    request["Cache-Control"] = "max-age=0"
    request["Upgrade-Insecure-Requests"] = "1"
    request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"
    request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"
    request["Accept-Language"] = "ko,en-US;q=0.9,en;q=0.8,ja;q=0.7,es;q=0.6"
    request["Cookie"] = "_ga=GA1.2.299807075.1542114254; NID_AUT=RYGpv2cV89C4BcmJ1g5pMTt+w7FKgDmHxsvO++KiiOg0MWspevtrkRD3QZtIyUeq; NID_SES=AAABpoUZNonG9oWGnmkloWvC8kwzuWs14ArqkYPALNjoWXc7ZeM9M6oeFK5UOSPGbZh8GZVfnyDwIyXEGXQsTgGTHbUJOQ4UEcK5Sw05NRiHhmSHeUZLWqE4VhUV0QhjSXVnt3/wB7EdtHSYIP5CKnJa5lmWZOAFltcv3UUXc2KazJ+F4MFj4x2auCBprTAzlkYRgogO6247FjWYsOkhqUOfFMKp3pyMu03S5nVmwlXV0dvCxNgF9YFnKgbpuBkJjkPBg4+TDckNFYUgITr8LbeYUAsyXH2txIVBC2CmsTInaWxup9uuwhS1dX2+3/sK3iJc58icc4SNMGxePJMseiomJC+rhIrA/fWh8aJV7TLzh4NQd+HymHABWRfrj0w/Y2+keHia2/P8it1fvKgC0diyGhX3stAvNDBqoJwf/lVqvS2iEtwa8vb67kbcsFVJUKya8LJuezF+a32v+jcQT4YmaHOXoZa/q3wXmJVLKxKRvMzQW8LLErpaaLweqw1JFB247Iudq6Lo1T24Wvb4vdKijo8pgAXxWZNk8R78pVi2n0RAHXj3XKCSpowjf/QfH5boHg==; _gid=GA1.2.1707587280.1546705342; wcs_bt=b942b9bd976724:1546705712"

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    response
  end

  def next_request(page_index)
    uri = URI.parse("https://spacecloud.kr/search")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/x-www-form-urlencoded; charset=UTF-8"
    request["Cookie"] = "_ga=GA1.2.299807075.1542114254; NID_AUT=RYGpv2cV89C4BcmJ1g5pMTt+w7FKgDmHxsvO++KiiOg0MWspevtrkRD3QZtIyUeq; NID_SES=AAABpoUZNonG9oWGnmkloWvC8kwzuWs14ArqkYPALNjoWXc7ZeM9M6oeFK5UOSPGbZh8GZVfnyDwIyXEGXQsTgGTHbUJOQ4UEcK5Sw05NRiHhmSHeUZLWqE4VhUV0QhjSXVnt3/wB7EdtHSYIP5CKnJa5lmWZOAFltcv3UUXc2KazJ+F4MFj4x2auCBprTAzlkYRgogO6247FjWYsOkhqUOfFMKp3pyMu03S5nVmwlXV0dvCxNgF9YFnKgbpuBkJjkPBg4+TDckNFYUgITr8LbeYUAsyXH2txIVBC2CmsTInaWxup9uuwhS1dX2+3/sK3iJc58icc4SNMGxePJMseiomJC+rhIrA/fWh8aJV7TLzh4NQd+HymHABWRfrj0w/Y2+keHia2/P8it1fvKgC0diyGhX3stAvNDBqoJwf/lVqvS2iEtwa8vb67kbcsFVJUKya8LJuezF+a32v+jcQT4YmaHOXoZa/q3wXmJVLKxKRvMzQW8LLErpaaLweqw1JFB247Iudq6Lo1T24Wvb4vdKijo8pgAXxWZNk8R78pVi2n0RAHXj3XKCSpowjf/QfH5boHg==; _gid=GA1.2.1707587280.1546705342; wcs_bt=b942b9bd976724:1546705945"
    request["Origin"] = "https://spacecloud.kr"
    request["Accept-Language"] = "ko,en-US;q=0.9,en;q=0.8,ja;q=0.7,es;q=0.6"
    request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"
    request["Accept"] = "text/html, */*; q=0.01"
    request["Referer"] = "https://spacecloud.kr/search?q=%EC%8B%A0%EB%85%BC%ED%98%84%EC%97%AD%20%EC%8A%A4%ED%84%B0%EB%94%94%EB%A3%B8"
    request["X-Requested-With"] = "XMLHttpRequest"
    request["Connection"] = "keep-alive"
    request.set_form_data(
      "ajax" => "r",
      "cnvenFctsCds" => "",
      "maxPrc" => "",
      "minPrc" => "",
      "order" => "BEST_DESC",
      "page" => "#{page_index}",
      "q" => "신논현역 스터디룸",
      "rsvMthCd" => "",
      "rsvTpCd" => "",
      "tcnt" => "77",
      "useYmd" => "",
    )

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    response
  end

  def space_contents
    contents = []
    page = first_page.css('.box_space')
    page.each do |contents_node|
      attribute = build_attribute(contents_node)
      contents << attribute
    end
    [2, 3, 4].each do |i|
      page = next_page(i).css('.box_space')
      page.each do |contents_node|
        attribute = build_attribute(contents_node)
        contents << attribute
      end
    end
    contents
  end

  def build_attribute(contents_node)
    title = contents_node.css('.tit_space').text
    url = contents_node.css('._innerLink').first['href']
    url = "https://spacecloud.kr#{url}"
    value = contents_node.css('._innerLink').first['_spaceid']
    attribute = { title: title, url: url, value: value }
  end

  def first_page
    doc = Nokogiri::HTML(first_request.body)
  end

  def next_page(page_index)
    request = next_request(page_index)
    doc = Nokogiri::HTML(request.body)
  end
end
