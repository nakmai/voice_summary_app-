class AzureSpeechService
  include HTTParty
  
  def initialize
    @speech_key = Rails.application.config.azure_speech_key
    @speech_region = Rails.application.config.azure_speech_region
    @base_url = "https://#{@speech_region}.stt.speech.microsoft.com"
    
    validate_config!
  end

  # 音声ファイルから音声認識を実行
  def transcribe_audio(audio_file_path, language = 'ja-JP')
    return { success: false, error: '設定エラー: APIキーまたはリージョンが設定されていません' } unless config_valid?

    url = "#{@base_url}/speech/recognition/conversation/cognitiveservices/v1"
    
    headers = {
      'Ocp-Apim-Subscription-Key' => @speech_key,
      'Content-Type' => 'audio/wav',
      'Accept' => 'application/json'
    }
    
    query = {
      'language' => language,
      'format' => 'detailed'
    }

    begin
      # ファイル読み込み
      audio_data = File.read(audio_file_path)
      
      response = self.class.post(url, {
        headers: headers,
        query: query,
        body: audio_data,
        timeout: 30
      })

      if response.success?
        parse_recognition_result(response.parsed_response)
      else
        { success: false, error: "Azure Speech API エラー: #{response.code} - #{response.message}" }
      end
    rescue => e
      { success: false, error: "音声認識処理エラー: #{e.message}" }
    end
  end

  # リアルタイム音声認識（WebSocket使用）
  def start_realtime_recognition
    # 将来的にWebSocketでリアルタイム認識を実装
    { success: false, error: 'リアルタイム音声認識は準備中です' }
  end

  private

  def validate_config!
    Rails.logger.warn("Azure Speech Service: APIキーが設定されていません") if @speech_key.blank?
    Rails.logger.warn("Azure Speech Service: リージョンが設定されていません") if @speech_region.blank?
  end

  def config_valid?
    @speech_key.present? && @speech_region.present?
  end

  def parse_recognition_result(response)
    if response && response['RecognitionStatus'] == 'Success'
      {
        success: true,
        text: response['DisplayText'],
        confidence: response['Confidence'],
        offset: response['Offset'],
        duration: response['Duration']
      }
    else
      {
        success: false,
        error: response&.dig('RecognitionStatus') || 'Unknown error'
      }
    end
  end
end 