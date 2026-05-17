🚀 Automated Recon & Bug Bounty Environment Provisioner

This script automates the complete setup and configuration of a high-performance Reconnaissance and Bug Bounty hunting environment on Kali Linux. It handles system dependencies, configures dual-shell paths (Bash & Zsh), compiles low-level engines, and installs industry-standard Go and Python security tools.
⚡ One-Click Installation

To deploy the entire toolkit instantly without any manual configuration or caching issues, copy and paste the following command into your Kali Linux terminal:
Bash

curl -sL "https://raw.githubusercontent.com/kalilinux32211-cloud/recon-installer/main/install.sh?v=$RANDOM" | sudo bash

    Note: After the installation is complete, make sure to restart your terminal or run source ~/.zshrc (or source ~/.bashrc if using Bash) to activate all tools in your environment.

🛠️ Step-by-Step Architecture (How it Works)

The provisioning script executes sequentially through 7 structural phases:

    Privilege & System Sync: Checks for root/sudo access and performs a full system update (apt update && apt upgrade) to prevent dependency conflicts.

    Core Dependencies Mapping: Installs essential compiler tools, runtimes, and Linux security packages (git, make, gcc, libpcap-dev, python3-pip, etc.).

    Golang Pipeline Optimization: Automatically fetches and installs the latest stable version of Go from official sources, and injects persistence paths into both ~/.bashrc and ~/.zshrc.

    Mass Go Binary Compilation: Downloads, compiles, and installs the latest binary distributions of 13+ powerhouse recon utilities directly into the environment path.

    High-Speed DNS Engine Compilation: Clones and compiles MassDNS from C-source code for ultra-fast multi-threaded subdomain resolution.

    Specialized Python Framework Clusters: Deploys and automatically maps structural requirements for advanced URL and secret analysis frameworks (ParamSpider & SecretFinder).

    Asset Dictionary Integration: Syncs essential bug bounty dictionaries, including a shallow clone of SecLists and specialized XSS payload lists.

🧰 Included Tools & Capabilities

The framework maps out a comprehensive multi-layered reconnaissance pipeline:
1. Subdomain & Asset Discovery

    Subfinder: Fast passive subdomain enumeration tool.

    Amass: In-depth network mapping and active asset discovery.

    Puredns: Powerful DNS stub resolver capable of resolving millions of domains using MassDNS.

    MassDNS: High-performance DNS stub resolver for mass lookups.

2. URL & Endpoint Crawling

    Katana: Next-generation crawling and spidering framework.

    Hakrawler: Fast web crawler for discovering endpoints and assets.

    Gau (GetAllUrls): Fetches known URLs from AlienVault, Wayback Machine, and Common Crawl.

    Waybackurls: Fetches URLs that Wayback Machine knows about for a domain.

3. Probing & Fuzzing

    Httpx: Multi-purpose HTTP toolkit for probing target lists with high speed.

    Httprobe: Simple utility to take a list of domains and probe for working HTTP/HTTPS servers.

    Ffuf (Fast Fuzzing): Ultra-fast web fuzzer written in Go (Directory and parameter discovery).

    Dirsearch: Advanced command-line tool designed to brute force directories and files.

    Wfuzz: Flexible web application vulnerability scanner and fuzzer.

4. Vulnerability Scanning & Analysis

    Nuclei: Fast, template-based vulnerability scanner targeted at specific technologies.

    Dalfox: Powerful open-source XSS scanning tool and parameter analyzer.

    Sqlmap: Automated tool for detecting and exploiting SQL injection flaws.

    Nikto: Classic web server scanner for dangerous files and outdated software.

    WhatWeb: Next-generation web scanner identifying CMS, blogging platforms, and JavaScript libraries.

5. Parameter & Secret Extraction

    Gf & Gf-Patterns: Pattern matching wrapper for grep to find sensitive data (APIs, tokens, AWS keys).

    ParamSpider: Mining parameters from documentation, search engines, and archives.

    SecretFinder: Python script based on regular expressions to find sensitive data in JavaScript files.

6. Visual Recon & Wordlists

    Aquatone: Visual inspection tool for websites on a large number of hosts (Screenshotted recon).

    SecLists: The security tester's companion (Wordlists for usernames, passwords, URLs, sensitive data).

    PayloadBox-XSS: Specialized intruder payload list focused on Cross-Site Scripting.

📁 Directory Structures Created

The installer standardizes your workspace by setting up the following paths:

    ~/tools/ — Houses cloned Python repositories and standalone frameworks.

    ~/go/bin/ — Location of all compiled Go binaries.

    ~/wordlists/ — Dedicated repository for dictionaries and payload assets.

    ~/.config/ — Configuration directories pre-allocated for Subfinder and Puredns.
