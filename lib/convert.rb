# このクラスは不要になったよ…
module Convert
  include Common

  # ActiveModelからXMLにする
  def to_xml

    xml = ""
#    model_class = class_create(self.class.to_s)
    model_class = self.class.to_s.constantize

    return xml if model_class.blank?

    model_class::AttributeNames.each do | n |
#    Kernel.const_get(ary[0]).const_get(ary[1])::AttributeNames.each do | n |

      xml << "<" + n.to_s

      if self.__send__(n).to_s.blank?
        xml << "\sxsi\:nil\=\"true\"\s/\>"
      else
        xml << "\>"
        xml << self.__send__(n).to_s
        xml << "<\/" + n.to_s + "\>"
      end
    end

    return xml
  end

end
