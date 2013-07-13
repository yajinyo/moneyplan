###require 'nokogiri'

class Breakdown < ActiveRecord::Base
  attr_accessible :item



  #####################################
  # 初期化
  #
  def initialize(attributes={})
    attributes[:item] = "<breakdowns></breakdowns>" unless attributes.has_key?(:item)
    super
#    self.item = "<breakdowns></breakdowns>" unless attributes.has_key?(:item)
  end

  #####################################
  # xml文字列をdocに変換
  #
  def parse
#    @doc ||= Nokogiri::XML::Document.parse(self.item)
    Nokogiri::XML::Document.parse(self.item)
  end

=begin
  def self.find_by_id(id)
    xquery("/breakdowns/breakdown[id/text()=\"#{id.to_s.gsub('"', "")}\"]")
  end

  def self.xquery(xpath)
    select([
      columns.map{|col| col.name }.join(','),
      "array_to_string(xpath(#{sanitize_sql_array(['?', xpath])}, item), '||') as xml_data"
    ])
  end
=end

end
