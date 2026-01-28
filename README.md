# AI Studio ComfyUI 镜像

> 专业 AI 创作平台，基于 ComfyUI 的 Docker 镜像

[![GitHub](https://img.shields.io/badge/GitHub-SUZIXI--AI-blue)](https://github.com/SUZIXI-AI/ai-studio-comfyui)
[![AutoDL](https://img.shields.io/badge/AutoDL-Art-green)](https://www.autodl.art)

## 📋 基本信息

| 项目 | 值 |
|------|-----|
| 框架 | PyTorch 2.1.0 |
| CUDA | 12.1 |
| Python | 3.10 |
| 基础镜像 | Ubuntu 22.04 |

## ✨ 特性

- 预装 ComfyUI 最新版本
- 自动 GPU/CPU 模式检测
- 支持多种 GPU（4090、5090、A100 等）
- 开箱即用，无需配置环境

## 🚀 快速开始

### 1. 创建实例

在 [AutoDL Art](https://www.autodl.art) 搜索 `AI-Studio-ComfyUI`，选择此镜像创建实例

### 2. 启动服务

```bash
cd /root/ComfyUI
python main.py --listen 0.0.0.0 --port 6006
```

### 3. 访问服务

- ComfyUI 界面：`http://localhost:6006`

## 📁 目录结构

```
/root/
└── ComfyUI/                # ComfyUI 主程序
    ├── models/             # 模型目录
    │   ├── checkpoints/    # Stable Diffusion 模型
    │   ├── loras/          # LoRA 模型
    │   ├── vae/            # VAE 模型
    │   ├── embeddings/     # Embedding 文件
    │   └── controlnet/     # ControlNet 模型
    ├── custom_nodes/       # 自定义节点
    ├── input/              # 输入文件
    └── output/             # 输出文件
```

## 📦 模型放置

将模型文件放入对应目录：

| 模型类型 | 目录 |
|---------|------|
| Stable Diffusion | `models/checkpoints/` |
| LoRA | `models/loras/` |
| VAE | `models/vae/` |
| Embedding | `models/embeddings/` |
| ControlNet | `models/controlnet/` |

## 🔧 自定义节点

将节点放入 `/root/ComfyUI/custom_nodes/` 目录，重启服务即可生效

## ⚙️ 环境验证

```bash
cd /root/ComfyUI
python main.py --help
```

## 📄 许可证

MIT License

---

**AI Studio - 专业 AI 创作平台**
