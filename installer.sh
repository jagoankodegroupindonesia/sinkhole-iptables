#!/bin/bash
#
# installer.sh - one-liner installer for jagoankode_sinkhole-iptables
#
# Host this file di raw GitHub kamu, lalu jalankan di server dengan:
#   curl -fsSL https://raw.githubusercontent.com/jagoankodegroupindonesia/sinkhole-iptables/main/installer.sh | sudo bash -s -- <raw_blocklist_url>
#
set -e

# Ganti URL ini ke lokasi raw file "jagoankode_sinkhole-iptables" di repo kamu
CLI_URL="${JSK_CLI_URL:-https://raw.githubusercontent.com/jagoankodegroupindonesia/sinkhole-iptables/main/jagoankode_sinkhole-iptables}"

BLOCKLIST_URL="$1"
if [ -z "$BLOCKLIST_URL" ]; then
    echo "Usage: curl -fsSL <bootstrap_raw_url> | sudo bash -s -- <raw_blocklist_url>"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    echo "Harus dijalankan sebagai root (sudo)."
    exit 1
fi

echo "Mengambil CLI dari $CLI_URL ..."
curl -fsSL "$CLI_URL" -o /usr/local/bin/jagoankode_sinkhole-iptables
chmod +x /usr/local/bin/jagoankode_sinkhole-iptables

echo "Menjalankan instalasi..."
/usr/local/bin/jagoankode_sinkhole-iptables install "$BLOCKLIST_URL"
