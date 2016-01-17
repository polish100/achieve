class InquiriesController < ApplicationController
  def index
    @inquiry = Inquiry.new
    #render :action => 'index'
  end

  def confirm
    # 入力値のチェック
    #attr = params.require(:inquiry).permit(:name, :email, :message)
    #@inquiry = Inquiry.new(attr)
    @inquiry = Inquiry.new(inquiry_params)
    #createではなくnew！createだとDBに登録されてしまう。

    if @inquiry.valid?
      # OK。確認画面を表示
      render :action => 'confirm'
    else
      # NG。入力画面を再表示
      render :action => 'index'
    end
  end

  def thanks
    if params[:back]
      @inquiry = Inquiry.new(inquiry_params)
      #render :index
      redirect_to action: :index
    end
    Inquiry.create(inquiry_params)
  end


  private

    def inquiry_params
      params.require(:inquiry).permit(:name, :email, :message)
    end

end
