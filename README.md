# 音声要約アプリ

Azure Speech to TextとOpenAI APIを使用した音声入力要約アプリです。

## 機能

- 🎤 音声録音機能（準備中）
- 🔤 Azure Speech to Text による音声認識
- 🤖 OpenAI API による自動要約
- 👥 多人数話者の聞き分け（準備中）
- 📝 音声記録の管理（作成・編集・削除・検索）
- 📋 Notion形式でのコピー機能
- 📱 レスポンシブなUI

## 技術スタック

- **Backend**: Ruby 3.3.0 + Rails 7.1.5.1
- **Database**: SQLite3
- **Frontend**: HTML + Tailwind CSS + JavaScript
- **Container**: Docker + Docker Compose
- **APIs**: Azure Speech Service + OpenAI API

## セットアップ

### 1. リポジトリのクローン

```bash
git clone https://github.com/nakmai/voice_summary_app-.git
cd voice_summary_app-
```

### 2. 環境変数の設定

.envファイルを作成してAPIキーを設定：

```bash
cp .env.example .env
```

.envファイルを編集して実際のAPIキーを入力：

```bash
# Azure Speech Service
AZURE_SPEECH_KEY=your_actual_azure_speech_key
AZURE_SPEECH_REGION=japaneast

# OpenAI API
OPENAI_API_KEY=your_actual_openai_api_key
OPENAI_MODEL=gpt-3.5-turbo

# Rails Environment
RAILS_ENV=development
```

### 3. Dockerで起動

```bash
docker-compose up --build
```

### 4. ブラウザでアクセス

```
http://localhost:3000
```

## API設定詳細

### Azure Speech Service

1. [Azure Portal](https://portal.azure.com/)にアクセス
2. 「Speech Services」を検索して作成
3. リソース作成後、「キーとエンドポイント」からキーを取得
4. `.env`ファイルに以下を設定：
   ```
   AZURE_SPEECH_KEY=your_speech_service_key
   AZURE_SPEECH_REGION=japaneast  # または選択したリージョン
   ```

### OpenAI API

1. [OpenAI Platform](https://platform.openai.com/)にアクセス
2. 「API Keys」セクションで新しいAPIキーを作成
3. `.env`ファイルに以下を設定：
   ```
   OPENAI_API_KEY=your_openai_api_key
   OPENAI_MODEL=gpt-3.5-turbo  # または gpt-4
   ```

## ローカル環境での起動方法

Dockerを使わない場合：

```bash
# Ruby環境のセットアップ
rbenv install 3.3.0
rbenv local 3.3.0

# 依存関係のインストール
bundle install

# データベースのセットアップ
rails db:create db:migrate

# サーバー起動
rails server
```

## Docker コマンド

```bash
# 初回起動
docker-compose up --build

# 通常起動
docker-compose up

# バックグラウンド起動
docker-compose up -d

# コンテナに入る
docker-compose exec web bash

# ログ確認
docker-compose logs web

# 停止
docker-compose down

# 完全削除（ボリューム含む）
docker-compose down -v
```

## 使用方法

1. **環境変数設定**: `.env`ファイルにAPIキーを設定
2. **新規録音作成**: 「新規録音」ボタンから音声記録を作成
3. **音声認識**: 音声ファイルをアップロードして自動認識
4. **AI要約**: 認識されたテキストから自動要約を生成
5. **Notionコピー**: 要約をNotion形式でクリップボードにコピー

## セキュリティ

- **環境変数**: APIキーは`.env`ファイルで管理
- **Git除外**: `.env`ファイルは`.gitignore`で除外済み
- **テンプレート**: `.env.example`で設定例を提供

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。
