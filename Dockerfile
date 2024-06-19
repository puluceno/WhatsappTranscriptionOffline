FROM openwa/wa-automate
USER root
WORKDIR /build
RUN apt update; apt install -y git g++ make;
RUN git clone https://github.com/ggerganov/whisper.cpp /build/whisper.cpp; \
    cd /build/whisper.cpp; \
    make small

FROM  openwa/wa-automate
USER root
WORKDIR /app
COPY . /app/
COPY --from=0 /build/whisper.cpp/main /app/whisper
COPY --from=0 /build/whisper.cpp/models/ggml-small.bin /app/
RUN apt update ; apt install -y ffmpeg ;  npm install ; rm -fR /var/lib/apt/lists/*
ENTRYPOINT ["node","index.js"]
