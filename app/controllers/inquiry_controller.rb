class InquiryController < ApplicationController
  def index
    @inquiry = Inquiry.new
    render :action => 'index'
    #viewsに飛ぶための設定
    #無くても、コントローラ名とアクション名で自動的にviewsに行けるけど明示！
  end

  def confirm
    @inquiry = Inquiry.new(params[:inquiry])
    if @inquiry.valid?
      #OK。確認画面を表示
      render :action => 'confirm'
    else
      #NG。入力画面を再表示
      render :action => 'index'
    end
  end

  def thanks

  end
end
