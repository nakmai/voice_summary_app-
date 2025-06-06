class VoiceRecordsController < ApplicationController
  before_action :set_voice_record, only: [:show, :edit, :update, :destroy]

  # GET /voice_records
  def index
    @voice_records = VoiceRecord.order(created_at: :desc).page(params[:page]).per(10)
    @voice_records = @voice_records.where("title LIKE ?", "%#{params[:search]}%") if params[:search].present?
  end

  # GET /voice_records/1
  def show
  end

  # GET /voice_records/new
  def new
    @voice_record = VoiceRecord.new
  end

  # GET /voice_records/1/edit
  def edit
  end

  # POST /voice_records
  def create
    @voice_record = VoiceRecord.new(voice_record_params)
    @voice_record.recorded_at ||= Time.current

    if @voice_record.save
      redirect_to @voice_record, notice: '音声記録が正常に作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /voice_records/1
  def update
    if @voice_record.update(voice_record_params)
      redirect_to @voice_record, notice: '音声記録が正常に更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /voice_records/1
  def destroy
    @voice_record.destroy
    redirect_to voice_records_url, notice: '音声記録が削除されました。'
  end

  # POST /voice_records/transcribe
  def transcribe
    # Azure Speech to Text の実装は後で追加
    render json: { success: true, message: '音声認識機能は準備中です' }
  end

  # POST /voice_records/summarize
  def summarize
    # OpenAI API での要約実装は後で追加
    render json: { success: true, message: '要約機能は準備中です' }
  end

  private

  def set_voice_record
    @voice_record = VoiceRecord.find(params[:id])
  end

  def voice_record_params
    params.require(:voice_record).permit(:title, :original_text, :summary_text, :speakers, :user_name)
  end
end
