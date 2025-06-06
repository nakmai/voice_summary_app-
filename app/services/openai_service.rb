class OpenaiService
  include HTTParty
  base_uri 'https://api.openai.com/v1'

  def initialize
    @api_key = Rails.application.config.openai_api_key
    @model = Rails.application.config.openai_model
    
    validate_config!
  end

  # テキストの要約を生成
  def summarize_text(text, max_tokens = 500)
    return { success: false, error: '設定エラー: OpenAI APIキーが設定されていません' } unless config_valid?
    return { success: false, error: 'テキストが空です' } if text.blank?

    prompt = build_summary_prompt(text)
    
    begin
      response = self.class.post('/chat/completions', {
        headers: headers,
        body: {
          model: @model,
          messages: [
            {
              role: "system",
              content: "あなたは会議やディスカッションの内容を要約する専門家です。重要なポイントを簡潔にまとめてください。"
            },
            {
              role: "user", 
              content: prompt
            }
          ],
          max_tokens: max_tokens,
          temperature: 0.3
        }.to_json
      })

      if response.success?
        parse_summary_response(response.parsed_response)
      else
        { success: false, error: "OpenAI API エラー: #{response.code} - #{response.message}" }
      end
    rescue => e
      { success: false, error: "要約生成エラー: #{e.message}" }
    end
  end

  # 話者を識別（将来的な機能）
  def identify_speakers(text)
    return { success: false, error: '設定エラー: OpenAI APIキーが設定されていません' } unless config_valid?
    
    # 将来的に実装予定
    { success: false, error: '話者識別機能は準備中です' }
  end

  # 会議内容の構造化
  def structure_meeting_content(text)
    return { success: false, error: '設定エラー: OpenAI APIキーが設定されていません' } unless config_valid?
    return { success: false, error: 'テキストが空です' } if text.blank?

    prompt = build_structure_prompt(text)
    
    begin
      response = self.class.post('/chat/completions', {
        headers: headers,
        body: {
          model: @model,
          messages: [
            {
              role: "system",
              content: "会議やディスカッションの内容を構造化して、議題、決定事項、アクションアイテムに分けて整理してください。"
            },
            {
              role: "user",
              content: prompt
            }
          ],
          max_tokens: 800,
          temperature: 0.2
        }.to_json
      })

      if response.success?
        parse_structure_response(response.parsed_response)
      else
        { success: false, error: "OpenAI API エラー: #{response.code} - #{response.message}" }
      end
    rescue => e
      { success: false, error: "構造化エラー: #{e.message}" }
    end
  end

  private

  def validate_config!
    Rails.logger.warn("OpenAI Service: APIキーが設定されていません") if @api_key.blank?
  end

  def config_valid?
    @api_key.present?
  end

  def headers
    {
      'Authorization' => "Bearer #{@api_key}",
      'Content-Type' => 'application/json'
    }
  end

  def build_summary_prompt(text)
    <<~PROMPT
      以下の音声認識テキストを読んで、重要なポイントを要約してください。

      音声認識テキスト:
      #{text}

      要約に含めるべき内容:
      - 主な議題や話題
      - 重要な決定事項
      - 次のアクション
      - 参加者の主要な意見

      簡潔で分かりやすい日本語で要約してください。
    PROMPT
  end

  def build_structure_prompt(text)
    <<~PROMPT
      以下の音声認識テキストを構造化して整理してください。

      音声認識テキスト:
      #{text}

      以下の形式で構造化してください:
      ## 議題
      - 

      ## 決定事項
      - 

      ## アクションアイテム
      - 

      ## その他の重要な内容
      - 
    PROMPT
  end

  def parse_summary_response(response)
    if response && response['choices'] && response['choices'].any?
      content = response['choices'][0]['message']['content']
      {
        success: true,
        summary: content.strip,
        usage: response['usage']
      }
    else
      { success: false, error: 'OpenAI APIからの応答が不正です' }
    end
  end

  def parse_structure_response(response)
    if response && response['choices'] && response['choices'].any?
      content = response['choices'][0]['message']['content']
      {
        success: true,
        structured_content: content.strip,
        usage: response['usage']
      }
    else
      { success: false, error: 'OpenAI APIからの応答が不正です' }
    end
  end
end 