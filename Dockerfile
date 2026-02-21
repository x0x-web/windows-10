FROM debian:sid-slim

RUN DEBIAN_FRONTEND=noninteractive apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install sudo --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install wget --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install ca-certificates curl --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install iptables --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install qemu-utils --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install p7zip-full --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install openssh-server --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install htop --no-install-recommends --yes
RUN DEBIAN_FRONTEND=noninteractive apt-get install ethtool --no-install-recommends --yes

# Install fastfetch and speedtest via APT
RUN DEBIAN_FRONTEND=noninteractive apt-get install fastfetch speedtest-cli --no-install-recommends --yes

# Install official docker & docker-compose
RUN DEBIAN_FRONTEND=noninteractive apt-get install docker.io docker-compose-v2 --no-install-recommends --yes

# Install GitHub CLI
RUN DEBIAN_FRONTEND=noninteractive apt-get install gh --no-install-recommends --yes

# Install Tailscale securely from official script
RUN curl -fsSL https://tailscale.com/install.sh | sh

# Cleanup APT cache to keep the image small
RUN rm --recursive --force /var/lib/apt/lists/*

