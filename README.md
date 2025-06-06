# 音声要約アプリ

Azure Speech to TextとOpenAI APIを使用した音声入力要約アプリです。

## 機能

- 🎤 音声録音機能（準備中）
- 🔤 Azure Speech to Text による音声認識（準備中）
- 🤖 OpenAI API による自動要約（準備中）
- 👥 多人数話者の聞き分け（準備中）
- 📝 音声記録の管理（作成・編集・削除・検索）
- 📋 Notion形式でのコピー機能
- 📱 レスポンシブなUI

## 技術スタック

- **Backend**: Ruby 3.3.0 + Rails 7.1.5.1
- **Database**: SQLite3
- **Frontend**: HTML + Tailwind CSS + JavaScript
- **Container**: Docker + Docker Compose

## セットアップ

### Dockerを使用した起動方法（推奨）

1. リポジトリをクローン
```bash
git clone [repository-url]
cd voice_summary_app
```

2. Docker Composeでアプリケーションを起動
```bash
docker-compose up --build
```

3. ブラウザで以下にアクセス
```
http://localhost:3000
```

### ローカル環境での起動方法

1. Ruby 3.3.0とRailsをインストール
```bash
rbenv install 3.3.0
rbenv local 3.3.0
gem install rails
```

2. 依存関係をインストール
```bash
bundle install
```

3. データベースをセットアップ
```bash
rails db:create db:migrate
```

4. サーバーを起動
```bash
rails server
```

## Docker コマンド

### 初回起動
```bash
docker-compose up --build
```

### 通常起動
```bash
docker-compose up
```

### バックグラウンド起動
```bash
docker-compose up -d
```

### コンテナに入る
```bash
docker-compose exec web bash
```

### コンテナを停止・削除
```bash
docker-compose down
```

### ボリュームも含めて完全削除
```bash
docker-compose down -v
```

## API設定（今後実装）

以下の環境変数を設定してください：

```bash
# Azure Speech Service
AZURE_SPEECH_KEY=your_azure_speech_key
AZURE_SPEECH_REGION=your_azure_region

# OpenAI API
OPENAI_API_KEY=your_openai_api_key
```

## 使用方法

1. **新規録音作成**: 「新規録音」ボタンから音声記録を作成
2. **手動テスト**: 音声録音機能の代わりに手動でテキストを入力
3. **要約作成**: 手動で要約を入力（AI機能は準備中）
4. **Notionコピー**: 要約をNotion形式でクリップボードにコピー

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。
