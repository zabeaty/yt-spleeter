FROM ubuntu:latest
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -yq python python3-pip ffmpeg
RUN pip install --upgrade youtube-dl spleeter
RUN mkdir -p /data
WORKDIR /data
VOLUME /data
ENTRYPOINT [ "youtube-dl", "-x", "--audio-format", "mp3", "--audio-quality", "0", "--output", "/data/youtube-dl/%(title)s-%(id)s.%(ext)s", "--exec", "spleeter separate -o /data/spleeter {} && spleeter separate -p spleeter:4stems -o /data/spleeter_4_stems {} && spleeter separate -p spleeter:5stems -o /data/spleeter_5_stems {}" ]