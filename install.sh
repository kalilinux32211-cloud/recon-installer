#!/bin/bash

# Real-time console color matrices
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}[*] Initializing automated environment provisioning...${NC}"

# Check privilege layer
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[!] Error: Please run this script with sudo or as root.${NC}"
  exit 1
fi

# 1. Base Environment System Update & Dependency Core
echo -e "${GREEN}[+] Running system update and mapping base dependencies...${NC}"
apt-get update -y && apt-get upgrade -y
apt-get install -y git wget curl unzip make gcc python3 python3-pip python3-venv libpcap-dev whois whatweb nmap nikto sqlmap dirsearch wfuzz

# 2. Golang Pipeline Optimization
echo -e "${GREEN}[+] Provisioning Golang environment...${NC}"
if [ ! -d "/usr/local/go" ]; then
    GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1)
    wget "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz" -O /tmp/go.tar.gz
    tar -C /usr/local -xzf /tmp/go.tar.gz
    rm /tmp/go.tar.gz
fi

# Hardcoding path persistence across profile initializers
grep -q "GOPATH" ~/.bashrc || echo 'export GOPATH=$HOME/go' >> ~/.bashrc
grep -q "usr/local/go/bin" ~/.bashrc || echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc

export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# Pre-allocating configuration structures
mkdir -p ~/.config/subfinder
mkdir -p ~/.config/puredns
mkdir -p ~/wordlists
mkdir -p ~/tools

echo -e "${BLUE}[*] Golang environment active. Proceeding with installations...${NC}"

# 3. Mass Go Binary Compilation
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/owasp-amass/amass/v4/...@latest
go install -v github.com/d3mondev/puredns/v2@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/hakluke/hakrawler@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/tomnomnom/waybackurls@latest
go install -v github.com/tomnomnom/gf@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/tomnomnom/httprobe@latest
go install -v github.com/ffuf/ffuf/v2@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/hahwul/dalfox/v2@latest

# Fetching Gf-Patterns
if [ ! -d "~/.gf" ]; then
    rm -rf ~/.gf
    git clone https://github.com/1ndianl33t/Gf-Patterns ~/.gf
fi

# 4. Compiling MassDNS Source Core
if [ ! -f "/usr/local/bin/massdns" ]; then
    echo -e "${GREEN}[+] Compiling MassDNS engine...${NC}"
    rm -rf /tmp/massdns
    git clone https://github.com/blechschmidt/massdns.git /tmp/massdns
    cd /tmp/massdns && make && cp bin/massdns /usr/local/bin/
    cd ~
fi

# 5. Specialized Python Framework Integrations
echo -e "${GREEN}[+] Compiling Python source framework clusters...${NC}"

# ParamSpider (Force fresh clone to avoid 'already exists' errors)
rm -rf ~/tools/ParamSpider
git clone https://github.com/devanshbatham/ParamSpider.git ~/tools/ParamSpider
[ -f ~/tools/ParamSpider/requirements.txt ] && pip3 install -r ~/tools/ParamSpider/requirements.txt --break-system-packages

# SecretFinder
rm -rf ~/tools/SecretFinder
git clone https://github.com/m4ll0k/SecretFinder.git ~/tools/SecretFinder
[ -f ~/tools/SecretFinder/requirements.txt ] && pip3 install -r ~/tools/SecretFinder/requirements.txt --break-system-packages

# Ghauri (Fixed: Installing directly from official PyPI repository)
python3 -m pip install ghauri --break-system-packages

# 6. Binary Asset Extraction (Aquatone)
if [ ! -f "~/go/bin/aquatone" ]; then
    echo -e "${GREEN}[+] Extracting Aquatone compilation package...${NC}"
    wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip -O /tmp/aquatone.zip
    unzip -o /tmp/aquatone.zip -d /tmp/aquatone_bin
    mv /tmp/aquatone_bin/aquatone ~/go/bin/
    rm -rf /tmp/aquatone.zip /tmp/aquatone_bin
fi

# 7. Core Asset Dictionary Mappings (Wordlists)
echo -e "${GREEN}[+] Syncing structural wordlist packages...${NC}"

# Clone SecLists only if missing
if [ ! -d "$HOME/wordlists/SecLists" ]; then
    git clone --depth 1 https://github.com/danielmiessler/SecLists.git ~/wordlists/SecLists
fi

# Fixed PayloadBox: Direct raw download without git clone username prompts
mkdir -p ~/wordlists/PayloadBox-XSS
wget -q "https://raw.githubusercontent.com/payloadbox/xss-payload-list/master/Intruder/xss-payload-list.txt" -O ~/wordlists/PayloadBox-XSS/xss-payload-list.txt

echo -e "${BLUE}[*] =================================================== ${NC}"
echo -e "${GREEN}[+] PROVISIONING SUCCESSFUL: Environment assets are live. ${NC}"
echo -e "${BLUE}[*] Execute 'source ~/.bashrc' or restart the terminal session. ${NC}"
echo -e "${BLUE}[*] =================================================== ${NC}"
