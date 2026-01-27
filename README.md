# AI Studio ComfyUI Docker 镜像

AI Studio - 专业 AI 创作平台，基于 ComfyUI 的 Docker 镜像。

## 特性

- 基于 PyTorch 2.1.0 + CUDA 12.1
- 预装 ComfyUI 最新版本
- 自动 GPU/CPU 模式检测
- 状态监控页面

## 端口说明

| 端口 | 服务 | 说明 |
|------|------|------|
| 6006 | 状态页 | 服务状态监控 API |
| 6008 | ComfyUI | ComfyUI Web 界面 |

## 快速开始

### 使用 Docker

```bash
# 拉取镜像
docker pull ai-studio-comfyui

# 运行容器（GPU 模式）
docker run -d \
  --gpus all \
  -p 6006:6006 \
  -p 6008:6008 \
  -v /path/to/models:/workspace/ComfyUI/models \
  -v /path/to/output:/workspace/ComfyUI/output \
  --name ai-studio-comfyui \
  ai-studio-comfyui

# 运行容器（CPU 模式）
docker run -d \
  -p 6006:6006 \
  -p 6008:6008 \
  -v /path/to/models:/workspace/ComfyUI/models \
  -v /path/to/output:/workspace/ComfyUI/output \
  --name ai-studio-comfyui \
  ai-studio-comfyui
```

### 访问服务

- 状态页: http://localhost:6006
- ComfyUI: http://localhost:6008

## 目录结构

```
/workspace/
├── ComfyUI/
│   ├── models/
│   │   ├── checkpoints/    # Stable Diffusion 模型
│   │   ├── loras/          # LoRA 模型
│   │   ├── vae/            # VAE 模型
│   │   ├── embeddings/     # Embedding 文件
│   │   └── controlnet/     # ControlNet 模型
│   ├── custom_nodes/       # 自定义节点
│   ├── output/             # 输出目录
│   └── input/              # 输入目录
└── start.sh                # 启动脚本
```

## 自定义节点

将自定义节点放入 `/workspace/ComfyUI/custom_nodes/` 目录，重启容器即可生效。

## 模型放置

将模型文件放入对应的 models 子目录：

- Stable Diffusion 模型 → `models/checkpoints/`
- LoRA 模型 → `models/loras/`
- VAE 模型 → `models/vae/`
- Embedding → `models/embeddings/`
- ControlNet → `models/controlnet/`

## 状态 API

访问 `http://localhost:6006/status` 获取服务状态：

```json
{
  "service": "AI Studio ComfyUI",
  "status": "running",
  "comfyui_port": 6008,
  "status_port": 6006,
  "version": "1.0"
}
```

## 环境变量

| 变量名 | 默认值 | 说明 |
|--------|--------|------|
| COMFYUI_PORT | 6008 | ComfyUI 端口 |
| STATUS_PORT | 6006 | 状态页端口 |

## 许可证

MIT License

## 作者

AI Studio Team

---

**AI Studio - 专业 AI 创作平台**
