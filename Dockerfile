FROM ubuntu:latest AS yts_os
RUN add-apt-repository universe && apt update && \
	DEBIAN_FRONTEND=noninteractive apt install -yq python3-pip ffmpeg bash gettext && \
	apt-get autoremove --purge -y && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

FROM yts_os AS yts_build
RUN pip install youtube-dl spleeter
RUN mkdir -p /data



FROM yts_build AS yts_app
LABEL maintainer="zabeaty@gmail.com"
ARG AUDIO_FORMAT="mp3"
ARG AUDIO_QUALITY="0"
ARG SPLEETER_STEMS="2"
ARG SPLEETER_COMMAND="spleeter separate -p spleeter:${SPLEETER_STEMS}stems -o /data/spleeter_${SPLEETER_STEMS}stems {}"
ARG OUTPUT_TPL="/data/youtube-dl/%(title)s-%(id)s.%(ext)s"
ARG ENTRYPOINT_COMMAND="youtube-dl -x --audio-format $AUDIO_FORMAT --audio-quality $AUDIO_QUALITY --output '$OUTPUT_TPL' --exec '$SPLEETER_COMMAND'"
RUN echo "#!/usr/bin/env bash\n\n$ENTRYPOINT_COMMAND \$1\n" > /entry.sh && chmod a+x /entry.sh 
VOLUME /data
WORKDIR /data
ENTRYPOINT [ "/entry.sh" ]
