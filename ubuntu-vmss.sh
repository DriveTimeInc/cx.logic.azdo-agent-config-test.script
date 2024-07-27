sudo apt-get update
sudo apt-get upgrade

# Install pre-requisite packages.
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    apt-transport-https \
    software-properties-common \
    zip \
    openssl \
    build-essential \
    git \
    wget \
    llvm \
    bzip2 \
    libssl-dev \
    zlib1g-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncurses-dev \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libbz2-dev \
    python3.11-venv


# Download the Microsoft repository GPG keys
wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Update the list of packages after we added packages.microsoft.com
sudo apt-get update

# Install PowerShell
sudo apt-get install -y powershell

# Install dotnet SDK
sudo apt-get install -y dotnet-sdk-6.0

# Add the GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update repository
sudo apt-get update

# Set to docker repo
apt-cache policy docker-ce

# Install docker-ce
sudo apt-get install -y docker-ce

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install argo rollouts
curl -LO "https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64"
chmod +x ./kubectl-argo-rollouts-linux-amd64
mv ./kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts

# # install pyenv
# mkdir -p /home/AzDevOps
# git clone https://github.com/pyenv/pyenv.git /home/AzDevOps/.pyenv

# # set env variables for provisioning
# export PYENV_ROOT="/home/AzDevOps/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"

# # load pyenv into the shell
# eval "$(pyenv init -)"

# # install 3.11.9
# pyenv install 3.11.9

# # set the system to use 3.11.9
# pyenv global 3.11.9

# # give all perms to the .pyenv folder
# chmod -R a+rwx /home/AzDevOps/.pyenv

# # setup pyenv entries in .bashrc
# echo 'export PYENV_ROOT="/home/AzDevOps/.pyenv"' >> /home/AzDevOps/.bashrc
# echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/AzDevOps/.bashrc
# echo 'eval "$(pyenv init -)"' >> /home/AzDevOps/.bashrc

# # setup pyenv entries in .profile
# echo 'export PYENV_ROOT="/home/AzDevOps/.pyenv"' >> /home/AzDevOps/.profile
# echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/AzDevOps/.profile
# echo 'eval "$(pyenv init -)"' >> /home/AzDevOps/.profile

# from: https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/use-python-version-v0?view=azure-pipelines#how-can-i-configure-a-self-hosted-agent-to-use-this-task
LOCAL_AGENT_TOOLS_DIR="/agent/_work/_tool"
LOCAL_PYTHON_MAJOR_VERSION="3"
LOCAL_PYTHON_MINOR_VERSION="11"
LOCAL_PYTHON_PATCH_VERSION="9"


LOCAL_PYTHON_MAJOR_MINOR_DIR="$LOCAL_AGENT_TOOLS_DIR/Python/$LOCAL_PYTHON_MAJOR_VERSION.$LOCAL_PYTHON_MINOR_VERSION"
LOCAL_PYTHON_MAJOR_MINOR_PATCH_DIR="$LOCAL_AGENT_TOOLS_DIR/Python/$LOCAL_PYTHON_MAJOR_VERSION.$LOCAL_PYTHON_MINOR_VERSION.$LOCAL_PYTHON_PATCH_VERSION"

# Create the directory for 3.11
mkdir -p "$LOCAL_PYTHON_MAJOR_MINOR_DIR"

# Create the directory for 3.11.9
mkdir -p "$LOCAL_PYTHON_MAJOR_MINOR_PATCH_DIR"

# Create the simlink from 3.11, to 3.11.9
# this is so the tool installer task can specify 3.11, or 3.11.9
ln -s "$LOCAL_PYTHON_MAJOR_MINOR_PATCH_DIR" "$LOCAL_PYTHON_MAJOR_MINOR_DIR"

# create the venv inside the 3.11.9/x64 directory
python3.11 -m venv "$LOCAL_PYTHON_MAJOR_MINOR_PATCH_DIR/x64"

# create the .complete file
touch "$LOCAL_PYTHON_MAJOR_MINOR_PATCH_DIR/x64.complete"


# # structure must match the following:
# $AGENT_TOOLSDIRECTORY/
#     Python/
#         3.11.9/
#             x64/
#                 {tool files}
#             x64.complete




