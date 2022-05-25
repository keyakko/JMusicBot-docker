# JMusicBot-docker

amd64の環境で [JMusicBot](https://github.com/Cosgy-Dev/JMusicBot-JP) を動かすことを目的としたリポジトリ。

# 使い方
```bash
sudo docker build \
  -t jmusicbot \
  --build-arg TOKEN="TOKEN" \
  --build-arg OWNER_ID="ID" \
  .

```
