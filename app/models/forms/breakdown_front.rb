require 'nokogiri'
class Forms::BreakdownFront

  include ActiveModel::Conversion
  extend  ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Serializers::Xml

  AttributeNames = Moneyplan::Application.config.attributes["breakdowns"].collect{|attr| attr.to_sym}

  attr_accessor *AttributeNames

  # to_xmlに必要
  def attributes
    Hash[*AttributeNames.collect{|key| [key, ""]}.flatten]
  end

  #####################################
  # 初期化
  #
  def initialize(attributes={})
      attributes ||= []
      attributes[:id] = Time.now.strftime("%Y%m%d%H%M%S%3N") unless attributes.has_key?(:id)
      attributes = attributes.symbolize_keys
      AttributeNames.each{|n| __send__("#{n}=", attributes[n]) rescue nil}
  end

  #####################################
  # 検索(全件)
  #
  def self.all

    forms_breakdown_fronts = []

    breakdown = Breakdown.first
    return forms_breakdown_fronts if breakdown.blank?

    doc = breakdown.parse 
    doc.encoding = "UTF-8"

    doc.xpath("/breakdowns/breakdown").each do |node|
      forms_breakdown_front = self.new
      node.children.each do |child_node|
        forms_breakdown_front.__send__("#{child_node.name}=", child_node.text)
      end

      forms_breakdown_fronts << forms_breakdown_front
    end

    return forms_breakdown_fronts
  end

  #####################################
  # 検索
  #
  def self.find(id)

    breakdown = Breakdown.first
    return nil if breakdown.blank?

    doc = breakdown.parse
    doc.encoding = "UTF-8"

    return nil if doc.xpath("/breakdowns/breakdown[id=#{id}]").blank?

    forms_breakdown_front = self.new
    doc.xpath("/breakdowns/breakdown[id=#{id}]").children.each do |node|
      forms_breakdown_front.__send__("#{node.name}=", node.text)
    end

    forms_breakdown_front.persisted = breakdown.persisted?

    return forms_breakdown_front
  end

  #####################################
  # 保存（新規）
  #
  def save

    breakdown = Breakdown.first
    if breakdown.blank?
      # レコードがない場合、ルートを作成
      breakdown = Breakdown.new
      breakdown.save!
    end

    doc = breakdown.parse
    doc.xpath("/breakdowns")[0] << to_xml(
                                            :root => "breakdown",
                                            :skip_instruct => true,
                                            :dasherize => false,
                                            :indent => 0,
                                            :save_with=> Nokogiri::XML::Node::SaveOptions::AS_XML
                                          )
    breakdown.item = doc.to_xml(
                                  :root => "breakdown",
                                  :dasherize => false,
                                  :indent => 0,
                                  :save_with=> Nokogiri::XML::Node::SaveOptions::AS_XML
                                ).gsub(">\n<", "><")
    breakdown.save!
    return true

  rescue Exception => ex
    return false
  end

  #####################################
  # 保存（更新）
  #
  def update_attributes(attributes={})

    attributes ||= {}
    attributes.each do |attr_name, attr_value|
      __send__("#{attr_name}=", attr_value)
    end

    breakdown = Breakdown.first
    return false if breakdown.blank?

    doc = breakdown.parse
    doc.xpath("/breakdowns/breakdown[id=#{self.id}]").remove
    doc.xpath("/breakdowns")[0] << to_xml(
                                            :root => "breakdown",
                                            :skip_instruct => true,
                                            :dasherize => false,
                                            :indent => 0,
                                            :save_with=> Nokogiri::XML::Node::SaveOptions::AS_XML
                                          )
    breakdown.item = doc.to_xml(
                                  :root => "breakdown",
                                  :dasherize => false,
                                  :indent => 0,
                                  :save_with=> Nokogiri::XML::Node::SaveOptions::AS_XML
                                ).gsub(">\n<", "><")
    breakdown.save!
    return true

  rescue Exception => ex
    return false
  end

  #####################################
  # 削除
  #
  def destroy

    breakdown = Breakdown.first
    return false if breakdown.blank?

    doc = breakdown.parse
    doc.xpath("/breakdowns/breakdown[id=#{self.id}]").remove
    breakdown.item = doc.to_xml(
                                  :root => "breakdown",
                                  :dasherize => false,
                                  :indent => 0,
                                  :save_with=> Nokogiri::XML::Node::SaveOptions::AS_XML
                                ).gsub(">\n<", "><")
    breakdown.save!
    return true

  rescue Exception => ex
    return false
  end







attr_writer :persisted

  # DBと関連がないため、固定でfalseを返す
  def persisted?
#    false
    @persisted
  end
end
