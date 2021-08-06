# YouTube downloader and music extractor

This project uses the youtube-dl and the spleeter tools to download youtube movie, extract music and convert to audio format and split audio tracks likes instrumental, vocals, piano, drums, etc

## Run using public image
```console
docker run --rm \
  -v /home/username/output_dir:/data \
  -it zabeaty/yt-spleeter \
  "$YOUTUBE_URL"
```

## Build docker image

```console
git clone https://github.com/zabeaty/yt-spleeter.git
cd yt-spleeter
docker build -t zabeaty/yt-spleeter .
```

### Usage after build

```console
docker run --rm -v /home/username/output_dir:/data -it zabeaty/yt-spleeter "$YOUTUBE_URL"
```
