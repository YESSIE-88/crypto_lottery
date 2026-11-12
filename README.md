# Crypto Lottery (Monero Solo Mining on Raspberry Pi 5)

A lightweight, automated repository for autonomous solo (lottery) mining of Monero (`XMRig`) on a Raspberry Pi 5. This setup ensures resilient network handling, secure environment variables, and seamless recovery after a complete power outage.

---

## Prerequisites & Hardware

* **Hardware:** Raspberry Pi 5 running Raspberry Pi OS (64-bit) connected via Ethernet (`eth0`).
* **Algorithm:** RandomX (`rx/0`)
* **Strategy:** Solo mining via HeroMiners pool using the `solo:` prefix.

---

## Step 1: System Dependencies & XMRig Build

Before cloning or setting up the automation scripts, ensure your system has the required build tools and libraries to compile XMRig from source.

1. **Install build dependencies:**
```bash
sudo apt update
sudo apt install -y git build-cmake cmake libhwloc-dev libuv1-dev libssl-dev
```

2. **Clone and build XMRig (adjacent to this repository):**
```bash
cd ~/Desktop
git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build && cd build
cmake ..
make -j$(nproc)
```

---

## Step 2: Permanent DNS Configuration (Power Outage Resilience)

Because power outages can reset dynamic network leases, your Raspberry Pi must have a static DNS nameserver configured so that it can resolve mining pool endpoints upon reboot.

1. Open the network configuration file:
```bash
sudo nano /etc/dhcpcd.conf
```


2. Add the static DNS entry for your Ethernet interface (`eth0`):
```text
interface eth0
static domain_name_servers=1.1.1.1 8.8.8.8
```


3. Save and exit, then restart networking services:
```bash
sudo systemctl restart dhcpcd
```



---

## Step 3: Repository Setup & Environment Variables

This repository uses an environment file (`.env`) to store sensitive wallet credentials securely without hardcoding them into scripts or tracking them in version control.

1. **Clone or place this repository** on your Desktop at `~/Desktop/crypto_lottery`.
2. **Create your local `.env` file** in the root of the repository:
```bash
nano ~/Desktop/crypto_lottery/.env
```


Add your Monero wallet address:
```env
MONERO_WALLET=your_actual_monero_wallet_address_here
```


3. **Verify scripts are executable:**
```bash
cd ~/Desktop/crypto_lottery
chmod +x network-wait.sh start.sh
```

---

## Step 4: Automation & Autostart Configuration

The system is configured to automatically launch the miner upon system boot (very handy following a power failure). It utilizes a network-wait script to ensure connectivity before starting the execution loop.
