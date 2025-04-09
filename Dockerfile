FROM ubuntu:latest


# Dockerfile
ARG NODE_VERSION=20.8.1  # 可设置默认值
ENV NODE_VERSION=${NODE_VERSION}

# 安装基础工具链
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 安装nvm（Node版本管理）
ENV NVM_VERSION=v0.39.5
RUN curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash \
    && echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc \
    && echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc \
    # 显式加载环境变量并安装Node
    && . ~/.bashrc \
    && nvm install "${NODE_VERSION}" \
    && nvm use "${NODE_VERSION}"

# 设置工作目录
WORKDIR /code