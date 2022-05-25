FROM alpine

# リストを残さずにパッケージを足す
# https://qiita.com/Tsuyozo/items/c706a04848c3fbbaf055
RUN apk add --update-cache --no-cache \
    openjdk11


# 必要なやつをとってくる
RUN mkdir /workdir
WORKDIR /workdir
RUN wget -O /workdir/MusicBot.jar \
    https://github.com/Cosgy-Dev/JMusicBot-JP/releases/download/0.6.8/JMusicBot-0.6.8.jar
RUN wget -O /workdir/config.txt \
    https://github.com/Cosgy-Dev/JMusicBot-JP/releases/download/0.6.7/config.txt


# 設定を環境変数を使いながらいい感じにする
# https://stackoverflow.com/questions/584894/environment-variable-substitution-in-sed
# https://docs.docker.jp/engine/reference/builder.html#arg
ARG TOKEN
ARG OWNER_ID
RUN sed -e "s/prefix = \".*\"/prefix = \"!\"/" /workdir/config.txt && \
    sed -e 's/^token = .*$/token = '"$TOKEN"'/' /workdir/config.txt && \
    sed -e 's/owner = .*$/owner = '"$OWNER_ID"'/' /workdir/config.txt && \
    sed -e "s/stopnousers = .*$/stopnousers = true/" /workdir/config.txt


# MusicBotしかこのコンテナで動かす予定はないから、ひとまずENTRYPOINTで
# https://hara-chan.com/it/infrastructure/docker-cmd-entrypoint-difference/#:~:text=%E4%BB%98%E3%81%91%E5%8A%A0%E3%81%88%E3%82%89%E3%82%8C%E3%81%9F-,CMD%E3%81%A8ENTRYPOINT%E3%81%AE%E3%80%8C%E5%BD%B9%E5%89%B2%E3%80%8D%E3%81%A8%E3%80%8C%E9%81%95%E3%81%84%E3%80%8D%E3%81%BE%E3%81%A8%E3%82%81,%E9%AB%98%E3%81%84%E8%A6%81%E7%B4%A0%E3%82%92%E8%A8%98%E8%BF%B0%E3%81%99%E3%82%8B%E3%80%82
ENTRYPOINT ["java", "-jar", "/workdir/MusicBot.jar"]
