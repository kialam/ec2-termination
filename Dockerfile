FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install ansible boto3 botocore

RUN ansible-galaxy collection install amazon.aws

WORKDIR /playbook

COPY . /playbook/

ENTRYPOINT ["ansible-playbook"]
