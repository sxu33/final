FROM ruby:3.3.0

# 安装必要的包
RUN apt-get update -qq && apt-get install -y build-essential libsqlite3-dev tzdata

# 设置工作目录
WORKDIR /app

# 复制Gemfile和Gemfile.lock并安装gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

# 复制项目文件
COPY . .

# 预编译资产
RUN bundle exec rails assets:precompile

# 暴露端口
EXPOSE 3000

# 启动应用并运行数据库迁移和填充数据
CMD ["bash", "-c", "bin/rails db:migrate && bin/rails db:seed && bin/rails server -b 0.0.0.0"]
