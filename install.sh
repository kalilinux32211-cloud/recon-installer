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

# 2. Golang Pipeline Optimization (Fetches latest stable build dynamically)
echo -e "${GREEN}[+] Provisioning Golang environment...${NC}"
GO_VERSION=$(curl -s https://go.dev/VERSION?m=text | head -n 1)
wget "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz" -O /tmp/go.tar.gz
rm -rf /usr/local/go
tar -C /usr/local -xzf /tmp/go.tar.gz
rm /tmp/go.tar.gz

# Hardcoding path persistence across profile initializers
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.bashrc

# Active session export (Crucial for sequential execution in non-interactive shells)
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin

# Pre-allocating configuration structures
mkdir -p ~/.config/subfinder
mkdir -p ~/.config/puredns
mkdir -p ~/wordlists
mkdir -p ~/tools

echo -e "${BLUE}[*] Golang deployment completed. Spinning up Go-based binaries...${NC}"

# 3. Mass Go Binary Compilation
# Subdomain Reconnaissance Cluster
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/owasp-amass/amass/v4/...@latest
go install -v github.com/d3mondev/puredns/v2@latest

# HTTP & URL Discovery Cluster
go install -v github.com/projectdiscovery/katana/cmd/katana@latest
go install -v github.com/hakluke/hakrawler@latest
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/tomnomnom/waybackurls@latest

# Filtering, Validating & Pattern Mapping Engines
go install -v github.com/tomnomnom/gf@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/tomnomnom/httprobe@latest

# Automated Vulnerability & Fuzzing Nodes
go install -v github.com/ffuf/ffuf/v2@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/hahwul/dalfox/v2@latest

# Fetching Gf-Patterns to root profile mapped structure
rm -rf ~/.gf
git clone https://github.com/1ndianl33t/Gf-Patterns ~/.gf

# 4. Compiling MassDNS Source Core
echo -e "${GREEN}[+] Compiling MassDNS engine...${NC}"
git clone https://github.com/blechschmidt/massdns.git /tmp/massdns
cd /tmp/massdns || exit
make
cp bin/massdns /usr/local/bin/
cd ~ || exit

# 5. Specialized Python Framework Integrations
echo -e "${GREEN}[+] Compiling Python source framework clusters...${NC}"

# ParamSpider
git clone https://github.com/devanshbatham/ParamSpider.git ~/tools/ParamSpider
pip3 install -r ~/tools/ParamSpider/requirements.txt --break-system-packages

# SecretFinder
git clone https://github.com/m4ll0k/SecretFinder.git ~/tools/SecretFinder
pip3 install -r ~/tools/SecretFinder/requirements.txt --break-system-packages

# Ghauri
pip3 install ghauri --break-system-packages

# 6. Binary Asset Extraction (Aquatone DOM Visualization)
echo -e "${GREEN}[+] Extracting Aquatone compilation package...${NC}"
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip -O /tmp/aquatone.zip
unzip /tmp/aquatone.zip -d /tmp/aquatone_bin
mv /tmp/aquatone_bin/aquatone ~/go/bin/
rm -rf /tmp/aquatone.zip /tmp/aquatone_bin

# 7. Core Asset Dictionary Mappings (Wordlists)
echo -e "${GREEN}[+] Syncing structural wordlist packages...${NC}"
git clone --depth 1 https://github.com/danielmiessler/SecLists.git ~/wordlists/SecLists
git clone https://github.com/payloadbox/xss-payload-list.git ~/wordlists/PayloadBox-XSS

echo -e "${BLUE}[*] =================================================== ${NC}"
echo -e "${GREEN}[+] PROVISIONING SUCCESSFUL: Environment assets are live. ${NC}"
echo -e "${BLUE}[*] Execute 'source ~/.bashrc' or restart the terminal session. ${NC}"
echo -e "${BLUE}[*] =================================================== ${NC}"
