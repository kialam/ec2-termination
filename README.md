# Ansible EC2 Termination Playbook

This repository contains an Ansible playbook that queries and terminates EC2 instances based on a filter. The playbook runs inside a **Podman** container.

## Prerequisites

Before running the playbook, ensure the following:

1. **Podman**: Install Podman on your system. Follow the [Podman installation guide](https://podman.io/getting-started/installation) if it's not already installed.

2. **AWS Credentials**:
   1. If you need to create credentials got to [AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html) and follow the instructions.
   2. Once you valid AWS credentials to interact with your EC2 instances. Ensure the following environment variables are set:

    - `AWS_ACCESS_KEY_ID`
    - `AWS_SECRET_ACCESS_KEY`
    - `AWS_REGION`

   You can set these environment variables using the following commands (replace with your actual values):

   ```bash
   export AWS_ACCESS_KEY_ID=your_access_key_id
   export AWS_SECRET_ACCESS_KEY=your_secret_access_key
   export AWS_REGION=your_aws_region
    ```

3. Build the Podman container image using the following command:
   1. Assuming the Dockerfile is in the current directory, run the following command to build the container image:

   ```bash
   podman build -t terminate_ec2_instances:local .

   ```

4. Verify the container image is built successfully by running the following command:

```bash
podman images
```

## Usage

Run the playbook using the following command:

Add `your_user_name` to filter the instances you want to terminate.

> [!WARNING]
> Be careful when running this playbook. It will terminate all EC2 instances that match the filter.

```bash
podman run --rm -it \
    -e AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
    -e AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
    -e AWS_REGION="$AWS_REGION" \
    -v "$(pwd)":/playbook \
    terminate_ec2_instances:local \
    ansible-playbook /playbook/terminate_ec2_instances.yml \
    -e "filter=your_use_name region=$AWS_REGION"
```