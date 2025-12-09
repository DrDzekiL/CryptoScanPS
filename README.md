<p align="center">
  <img src="assets/cryptoscanps-logo.svg" alt="CryptoScanPS logo" width="320">
</p>

<h1 align="center">CryptoScanPS</h1>

<p align="center">
  Minimalistic PowerShell tool for scanning the crypto market — part of my personal trading / AI stack.
</p>

<p align="center">
  <a href="https://learn.microsoft.com/powershell/">
    <img src="https://img.shields.io/badge/PowerShell-7%2B-14559A?style=for-the-badge&logo=powershell" alt="PowerShell 7+">
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-success?style=for-the-badge" alt="MIT License">
  </a>
  <img src="https://img.shields.io/badge/status-experimental-orange?style=for-the-badge" alt="Status: experimental">
</p>


---


⚡ What It Does

Loads a clean, human-readable config.json

Pulls data from a public exchange endpoint (demo mode)

Filters symbols by volume

Logs every run (because logs = truth)

Outputs clean JSON

Uses modular PowerShell design:

http.psm1 — requests

parser.psm1 — shaping data

utils.psm1 — helpers

No magic. No fragile wrappers. Just a reliable scanner.
