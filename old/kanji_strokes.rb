require 'rubygems'
gem 'nokogiri'
require 'nokogiri'

module KanjiStrokes

  def self.parse_strokes_from_xml

    doc = Nokogiri::XML.parse(IO.read('data/strokes.xml'))

    strokes_hash = {}

    for char in  (doc/:character)
      kanji = (char/:utf8).children.first.content
      strokes_hash[kanji] = []
      
      for stroke in char/:stroke
        
        points = []
        
        for point in (stroke/:point)

          x = point.attributes['x'].value.to_i
          y = point.attributes['y'].value.to_i
          
          points << [x,y]
        end
        
        strokes_hash[kanji] << points

      end
    end
    
    return strokes_hash
    
  end
  
  def self.strokes
    return @strokes if @strokes

    if File.exists?("strokes_dump")
      marshal = Marshal.load(IO.read("strokes_dump"))
    else
      marshal = self.parse_strokes_from_xml
      File.open("strokes_dump",'w') {|f| f.write(Marshal.dump(marshal)) }
    end
    @strokes ||= marshal
  end

end

