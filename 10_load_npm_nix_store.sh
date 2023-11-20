#!/bin/sh

(
	devbox run -- deno run -A npm:npm@latest show 'npm' versions --json | jq -r '.[]' | while read line; do
		# Don't download old or bleeding-edge versions so this doesn't take forever
		case "$line" in
			1.*) continue ;;
			2.*) continue ;;
			3.*) continue ;;
			4.*) continue ;;
			5.*) continue ;;
			*) ;;
		esac
		nix --extra-experimental-features 'nix-command flakes' store prefetch-file --json "https://registry.npmjs.org/npm/-/npm-${line}.tgz"
	done
) | tee npm.ndjson
