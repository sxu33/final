FROM ruby:3.3.0

# 安装必要的包
RUN apt-get update -qq && apt-get install -y build-essential libsqlite3-dev tzdata

# 安装 Bundler
RUN gem install bundler

# 设置工作目录
WORKDIR /app

# 复制 Gemfile 和 Gemfile.lock 并安装 gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# 复制整个应用
COPY . .

# 暴露端口
EXPOSE 3000

# 启动命令
CMD ["sh", "-c", "rm -f tmp/pids/server.pid && rails s -b '0.0.0.0'"]
