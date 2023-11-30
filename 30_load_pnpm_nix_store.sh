#!/bin/sh

(
	devbox run -- deno run -A npm:npm@latest show 'pnpm' versions --json | jq -r '.[]' | while read line; do
		# Don't download old or bleeding-edge versions so this doesn't take forever
		case "$line" in
			0.*) continue ;;
			1.*) continue ;;
			2.*) continue ;;
			3.*) continue ;;
			4.*) continue ;;
			*) ;;
		esac
		nix --extra-experimental-features 'nix-command flakes' store prefetch-file --json "https://registry.npmjs.org/pnpm/-/pnpm-${line}.tgz"
	done
) | tee pnpm.ndjson
