FROM python:3.11-slim

# Install Python dependencies and Ansible collections
RUN pip install --no-cache-dir \
    ansible==7.0.0 \
    boto3==1.28.0 \
    botocore==1.31.0 \
    && ansible-galaxy collection install amazon.aws

# Set the working directory
WORKDIR /playbook

# Copy the playbook into the image
COPY terminate_ec2_instances.yml /playbook/

# Set the default command to run your playbook
CMD ["ansible-playbook", "terminate_ec2_instances.yml"]
