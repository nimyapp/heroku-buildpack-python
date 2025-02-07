FROM heroku/heroku:22-build

ENV WORKSPACE_DIR="/app/builds" \
    S3_BUCKET="heroku-buildpack-python" \
    S3_PREFIX="heroku-22/" \
    STACK="heroku-22"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        libsqlite3-dev \
        python3-pip \
        python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/
RUN pip3 install --disable-pip-version-check --no-cache-dir -r /app/requirements.txt
RUN prisma generate

COPY . /app
