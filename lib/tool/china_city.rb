module Tool

  class ChinaCity
    CHINA = '000000' # 全国
    PATTERN = /(\d{2})(\d{2})(\d{2})/

    class << self
      def province(code)
        match(code)[1].ljust(6, '0')
      end

      def city(code)
        id_match = match(code)
        "#{id_match[1]}#{id_match[2]}".ljust(6, '0')
      end

      def data_as_json
        data = Tool::ChinaCity.data
        # todo 更好的方法拼接json
        data.map do |key, value|
          {
            id: key, 
            name: value[:text], 
            sublist: value[:children].map {|k, v| {id: k, name: v[:text], sublist: v[:children].map {|k,v| {id: k,name: v[:text]} } } }
          }
        end
      end

      def data
        unless @list
          @list = {}
          #http://github.com/RobinQu/LocationSelect-Plugin/raw/master/areas_1.0.json
          json = JSON.parse(File.read("#{Rails.root}/config/areas.json"))
          districts = json.values.flatten
          districts.each do |district|
            id = district['id']
            text = district['text']
            if id.end_with?('0000')
              @list[id] =  {:text => text, :children => {}}
            elsif id.end_with?('00')
              province_id = province(id)
              @list[province_id] = {:text => nil, :children => {}} unless @list.has_key?(province_id)
              @list[province_id][:children][id] = {:text => text, :children => {}}
            else
              province_id = province(id)
              city_id = city(id)
              @list[province_id] = {:text => text, :children => {}} unless @list.has_key?(province_id)
              @list[province_id][:children][city_id] = {:text => text, :children => {}} unless @list[province_id][:children].has_key?(city_id)
              @list[province_id][:children][city_id][:children][id] = {:text => text}
            end
          end
        end
        @list
      end

      def match(code)
        code.match(PATTERN)
      end
    end
  end

end
