FROM ubuntu:latest
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -yq python python3-pip ffmpeg
RUN pip install --upgrade youtube-dl spleeter
RUN mkdir -p /data/{youtube-dl,spleeter}
COPY ./bin/yt-spleeter /data/yt-spleeter
RUN chmod a+x /data/yt-spleeter
WORKDIR /data
ENTRYPOINT [ "youtube-dl", "-x", "--audio-format", "wav", "--audio-quality", "0", "--exec", "\"spleeter separate -o /data/ {}\"" ]