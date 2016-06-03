class InquiriesController < ApplicationController

  before_action :set_inquiry, only: [:show, :edit, :update, :destroy]

  def new

    if params[:back]
      @inquiry = Inquiry.new(inquiry_params)
      #render :index
      render :action => 'new'
    end
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
      render :action => 'new'
    end
  end

  def thanks
  #  Inquiry.create(inquiry_params)

  #@inquiry = Inquiry.new(params[:inquiry])
    @inquiry = Inquiry.create(inquiry_params)
#binding.pry

  InquiryMailer.received_email(@inquiry).deliver

  end

  def index
    @inquiries = Inquiry.all
  end

  def show
    @inquiries = Inquiry.find(params[:id])
  end


  def destroy

    @inquiry.destroy
      respond_to do |format|
        format.html { redirect_to inquiries_url, notice: 'お問合わせが削除されました' }
        format.json { head :no_content }
    end
  end


  private

    def set_inquiry
        @inquiry = Inquiry.find(params[:id])
    end

    def inquiry_params
      params.require(:inquiry).permit(:subject, :name, :email, :message)
    end

end
