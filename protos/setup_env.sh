#!/bin/bash

# Colors for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Environment name
ENV_NAME="proto"
PYTHON_VERSION="3.9"

echo -e "${BLUE}=== Setting up conda environment for MetaGPT ===${NC}"

# Check if conda is installed
if ! command -v conda &> /dev/null; then
    echo -e "${YELLOW}Conda is not installed or not in PATH${NC}"
    exit 1
fi

# Check if environment already exists
if conda env list | grep -q "^$ENV_NAME "; then
    echo -e "${GREEN}Environment $ENV_NAME already exists.${NC}"
    
    # Activate environment
    echo -e "${BLUE}Activating environment $ENV_NAME...${NC}"
    
    # Source conda initialization file for current shell
    if [[ "$SHELL" == */zsh ]]; then
        source $(conda info --base)/etc/profile.d/conda.sh
    elif [[ "$SHELL" == */bash ]]; then
        source $(conda info --base)/etc/profile.d/conda.sh
    fi
    
    conda activate $ENV_NAME
else
    echo -e "${YELLOW}Environment $ENV_NAME does not exist. Creating...${NC}"
    
    # Create environment with Python 3.9
    conda create -n $ENV_NAME python=$PYTHON_VERSION -y
    
    # Source conda initialization file for current shell
    if [[ "$SHELL" == */zsh ]]; then
        source $(conda info --base)/etc/profile.d/conda.sh
    elif [[ "$SHELL" == */bash ]]; then
        source $(conda info --base)/etc/profile.d/conda.sh
    fi
    
    # Activate environment
    conda activate $ENV_NAME
    
    # Update pip
    echo -e "${BLUE}Updating pip...${NC}"
    pip install --upgrade pip
fi

# Install dependencies from requirements.txt
echo -e "${BLUE}Installing dependencies from requirements.txt...${NC}"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pip install -r "$SCRIPT_DIR/requirements.txt" > /dev/null

# Check if metagpt is installed
if python -c "import pkg_resources; print('metagpt' in [pkg.key for pkg in pkg_resources.working_set])" | grep -q "True"; then
    echo -e "${GREEN}MetaGPT installed successfully!${NC}"
else
    echo -e "${YELLOW}Installing MetaGPT specifically...${NC}"
    pip install metagpt
fi

echo -e "${GREEN}=== Setup completed ===${NC}"
echo -e "${YELLOW}To use this environment in a new terminal, run:${NC}"
echo -e "${BLUE}conda activate $ENV_NAME${NC}"

# Add a message indicating that the environment is activated in current shell
echo -e "${GREEN}Environment $ENV_NAME is now activated in this session.${NC}"
