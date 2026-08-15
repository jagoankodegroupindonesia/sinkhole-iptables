#!/bin/bash
#
# installer.sh - One-liner installer untuk jagoankode_sinkhole-iptables
# Repository: https://github.com/jagoankodegroupindonesia/sinkhole-iptables
#
# Cara pasang di server (menggunakan default blocklist repo):
#   curl -fsSL https://raw.githubusercontent.com/jagoankodegroupindonesia/sinkhole-iptables/main/installer.sh | sudo bash
#
# Atau dengan custom raw blocklist URL:
#   curl -fsSL https://raw.githubusercontent.com/jagoankodegroupindonesia/sinkhole-iptables/main/installer.sh | sudo bash -s -- <custom_raw_blocklist_url>
#
set -e

CLI_URL="${JSK_CLI_URL:-https://raw.githubusercontent.com/jagoankodegroupindonesia/sinkhole-iptables/main/jagoankode_sinkhole-iptables}"
DEFAULT_BLOCKLIST="https://raw.githubusercontent.com/jagoankodegroupindonesia/sinkhole-iptables/main/blockinglist.txt"

BLOCKLIST_URL="${1:-$DEFAULT_BLOCKLIST}"

if [ "$EUID" -ne 0 ]; then
    echo "[!] Error: Script installer harus dijalankan sebagai root (sudo)."
    exit 1
fi

echo "[*] Mengunduh CLI dari: $CLI_URL"
curl -fsSL "$CLI_URL" -o /usr/local/bin/jagoankode_sinkhole-iptables
chmod +x /usr/local/bin/jagoankode_sinkhole-iptables

echo "[*] Menjalankan instalasi awal dengan blocklist: $BLOCKLIST_URL"
/usr/local/bin/jagoankode_sinkhole-iptables install "$BLOCKLIST_URL"

