#!/bin/bash

# AI Studio ComfyUI 启动脚本
# 端口: 6006 (状态页), 6008 (ComfyUI)

echo "============================================"
echo "   AI Studio - 专业 AI 创作平台"
echo "   ComfyUI Docker 镜像"
echo "============================================"

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 启动状态页服务 (端口 6006)
start_status_server() {
    echo -e "${BLUE}[AI Studio]${NC} 启动状态页服务 (端口 6006)..."
    cd /workspace
    python3 -c "
import http.server
import socketserver
import json
import threading

class StatusHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/' or self.path == '/status':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            status = {
                'service': 'AI Studio ComfyUI',
                'status': 'running',
                'comfyui_port': 6008,
                'status_port': 6006,
                'version': '1.0'
            }
            self.wfile.write(json.dumps(status, indent=2).encode())
        else:
            super().do_GET()

with socketserver.TCPServer(('', 6006), StatusHandler) as httpd:
    httpd.serve_forever()
" &
    echo -e "${GREEN}[AI Studio]${NC} 状态页服务已启动: http://localhost:6006"
}

# 启动 ComfyUI (端口 6008)
start_comfyui() {
    echo -e "${BLUE}[AI Studio]${NC} 启动 ComfyUI (端口 6008)..."
    cd /workspace/ComfyUI

    # 检查是否有 GPU
    if command -v nvidia-smi &> /dev/null; then
        echo -e "${GREEN}[AI Studio]${NC} 检测到 NVIDIA GPU"
        nvidia-smi
        python main.py --listen 0.0.0.0 --port 6008
    else
        echo -e "${BLUE}[AI Studio]${NC} 未检测到 GPU，使用 CPU 模式"
        python main.py --listen 0.0.0.0 --port 6008 --cpu
    fi
}

# 主函数
main() {
    echo ""
    echo -e "${GREEN}[AI Studio]${NC} 正在初始化服务..."
    echo ""

    # 启动状态页
    start_status_server

    # 等待状态页启动
    sleep 2

    echo ""
    echo -e "${GREEN}[AI Studio]${NC} =================================="
    echo -e "${GREEN}[AI Studio]${NC} 服务地址:"
    echo -e "${GREEN}[AI Studio]${NC}   状态页: http://localhost:6006"
    echo -e "${GREEN}[AI Studio]${NC}   ComfyUI: http://localhost:6008"
    echo -e "${GREEN}[AI Studio]${NC} =================================="
    echo ""

    # 启动 ComfyUI (前台运行)
    start_comfyui
}

# 执行主函数
main
