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
    libbz2-dev
    

#python3.11-venv

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

# install pyenv
git clone https://github.com/pyenv/pyenv.git /usr/local/bin/.pyenv

# set env variables for provisioning
export PYENV_ROOT="/usr/local/bin/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# load pyenv into the shell
eval "$(pyenv init -)"

# install 3.11.9
pyenv install 3.11.9

# set the system to use 3.11.9
pyenv global 3.11.9

# from: https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/use-python-version-v0?view=azure-pipelines#how-can-i-configure-a-self-hosted-agent-to-use-this-task
# also from: https://dev.to/akaszynski/create-an-azure-self-hosted-agent-without-going-insane-173g
LOCAL_AGENT_TOOLS_DIR="/agent/_work/_tool"

# # structure must match the following:
# $AGENT_TOOLSDIRECTORY/
#     Python/
#         3.11/ -> 3.11.9/
#         3.11.9/
#             x64/
#                 {tool files}
#             x64.complete

# Create the directory for 3.11
mkdir -p "$LOCAL_AGENT_TOOLS_DIR/Python/3.11"

# Create the directory for 3.11.9
mkdir -p "$LOCAL_AGENT_TOOLS_DIR/Python/3.11.9"

# Create the simlink from 3.11, to 3.11.9
# this is so the tool installer task can specify 3.11, or 3.11.9
ln -s "$LOCAL_AGENT_TOOLS_DIR/Python/3.11.9" "$LOCAL_AGENT_TOOLS_DIR/Python/3.11"

# create the venv inside the 3.11.9/x64 directory
# the python3.11 command is from the python3.11-venv apt package
# python3.11 -m venv "$LOCAL_AGENT_TOOLS_DIR/Python/3.11.9/x64"
python -m venv "$LOCAL_AGENT_TOOLS_DIR/Python/3.11.9/x64"

# create the .complete file
touch "$LOCAL_AGENT_TOOLS_DIR/Python/3.11.9/x64.complete"

