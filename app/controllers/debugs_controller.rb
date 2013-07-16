# デバッグ用コントローラ
class DebugsController < ApplicationController

	def view_item
    @breakdown = Breakdown.first
	end

end
