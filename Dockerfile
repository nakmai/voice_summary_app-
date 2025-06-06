# Ruby 3.3.0の公式イメージを使用
FROM ruby:3.3.0

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    npm \
    sqlite3 \
    libsqlite3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /app

# bundlerをアップデート
RUN gem update bundler

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundler設定
ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

# Gemをインストール
RUN bundle install

# アプリケーションのソースコードをコピー
COPY . .

# データベースディレクトリを作成
RUN mkdir -p db

# アセットをプリコンパイル（本番環境用）
# RUN bundle exec rails assets:precompile

# ポート3000を公開
EXPOSE 3000

# 実行可能なファイルの権限を設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# エントリーポイントを設定
ENTRYPOINT ["entrypoint.sh"]

# デフォルトコマンド
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"] 