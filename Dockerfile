# AI Studio ComfyUI Docker Image
# 基于 PyTorch 官方镜像

FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

LABEL maintainer="AI Studio"
LABEL version="1.0"
LABEL description="AI Studio - 专业 AI 创作平台 ComfyUI 镜像"

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV COMFYUI_PORT=6008
ENV STATUS_PORT=6006

# 设置工作目录
WORKDIR /workspace

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    vim \
    htop \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# 克隆 ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI

# 安装 ComfyUI 依赖
WORKDIR /workspace/ComfyUI
COPY requirements.txt /workspace/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir -r /workspace/ComfyUI/requirements.txt

# 创建必要目录
RUN mkdir -p /workspace/ComfyUI/models/checkpoints \
    && mkdir -p /workspace/ComfyUI/models/loras \
    && mkdir -p /workspace/ComfyUI/models/vae \
    && mkdir -p /workspace/ComfyUI/models/embeddings \
    && mkdir -p /workspace/ComfyUI/models/controlnet \
    && mkdir -p /workspace/ComfyUI/custom_nodes \
    && mkdir -p /workspace/ComfyUI/output \
    && mkdir -p /workspace/ComfyUI/input

# 复制启动脚本
COPY start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

# 暴露端口
# 6006 - 状态页
# 6008 - ComfyUI
EXPOSE 6006 6008

# 工作目录
WORKDIR /workspace

# 启动命令
CMD ["/workspace/start.sh"]
