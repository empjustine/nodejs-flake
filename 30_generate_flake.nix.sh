#!/bin/sh

(
	cat flake.nix-head
	jq -r '
def storeFile:
  .storePath[44:];
def pname:
  storeFile | split("-")[0];
def nixVersion:
  storeFile[:-4] | split("-")[1:] | join("-") | gsub("\\."; "_");
def fetchUrl:
  "https://registry.npmjs.org/\(pname)/-/\(storeFile)";
"    packages.x86_64-linux.\(pname)_\(nixVersion) = buildNpmTgz { name = \"\(pname)_\(nixVersion)\"; url = \"\(fetchUrl)\"; hash = \"\(.hash)\"; };"
' npm.ndjson yarn.ndjson | sort -u
	cat flake.nix-tail
) | tee flake.nix
