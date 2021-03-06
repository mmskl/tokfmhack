FROM python:3.7.2-alpine

ENV APP_DIR /opt/Tokfmhack

RUN mkdir /opt/Tokfmhack
WORKDIR /opt/Tokfmhack/tokfmhack
RUN mkdir -p /opt/Tokfmhack/data

COPY ./tokfmhack /opt/Tokfmhack/tokfmhack
COPY ./requirements.txt /opt/Tokfmhack/requirements.txt
COPY ./schema.sql /opt/Tokfmhack/schema.sql

RUN apk add  ffmpeg g++ gcc libxslt libxslt-dev sqlite --no-cache jpeg zlib jpeg-dev zlib-dev build-base freetype freetype-dev && \
    pip install -r /opt/Tokfmhack/requirements.txt && \
    apk del libxslt-dev jpeg-dev zlib-dev freetype-dev build-base

RUN sqlite3 /opt/Tokfmhack/data/podcasts.db < /opt/Tokfmhack/schema.sql

ENTRYPOINT ["python", "main.py"]
