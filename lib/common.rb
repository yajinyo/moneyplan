# このクラスは不要になったよ…
module Common

  # クラス名（文字列）をクラスオブジェクトに変換する
  def class_create(model_name=nil)

    return nil if model_name.blank?

    ary = model_name.to_s.split("::")

    obj = nil
    ary.each_with_index do |str, index|
      if index == 0
        obj = Kernel.const_get(str)
      else
        obj = obj.const_get(str)
      end
    end

    return obj

  rescue
p "-------------------- rescue! --------------------"
    return nil
  end

end
