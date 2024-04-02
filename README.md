ollama.sh是集ollama安装，运行一体的，每次运行会检测ollama是否安装

如果出现:Port 11434 is already in use. 
解决方案:
```shell
#查看占用端口的id
lsof -i :11434
#干掉它
kill -9 查询出来的id
```

### 启动ollama
```shell
#赋予可以执行权限
chmod +x ollama.sh
#执行
./ollama.sh
```
### docker代理

```
mirrors.nju.edu.cn
daocloud.io/
```

### open-webui

```shell
#docker-compose.yml environment中设置本机穿墙代理，否则无法下载huggingface中模型，会导致运行失败
#data目录中新增open-webui目录
#LiteLLM是各种大模型代理
https://docs.openwebui.com/tutorial/litellm
```

### 启动chatOllama web ui

首次运行新建目录,目录结构如下:
```
├── data
│   ├── .chatollama
│   └── chromadb_data
├── docker-compose.yml
├── ollama.sh
├── README.md
└── services
```

```shell
sudo docker-compose up
```

注意:如果是首次启动，在`./data/.chatollama`文件夹中，如果没有`chatollama.sqlite`文件，则运行：
```shell
docker compose exec chatollama npx prisma migrate dev
```

### 使用说明

1、settings->Ollama Server Setting->Host: http://host.docker.internal:11434

2、需要使用知识库，需要解码模型：nomic-embed-text

3、OpenAI Embedding Model（任选一个）

```
text-embedding-3-large

text-embedding-3-small

text-embedding-ada-002

```

[chatOllama仓库](https://github.com/sugarforever/chat-ollama/)

[Ollama仓库](https://github.com/ollama/ollama)

[Open Web UI](https://github.com/open-webui/open-webui)