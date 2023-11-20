#!/bin/sh

(
	devbox run -- deno run -A npm:npm@latest show 'yarn' versions --json | jq -r '.[]' | while read line; do
		# Don't download old or bleeding-edge versions so this doesn't take forever
		case "$line" in
			0.*) continue ;;
			2.*) continue ;;
			*) ;;
		esac
		nix --extra-experimental-features 'nix-command flakes' store prefetch-file --json "https://registry.npmjs.org/yarn/-/yarn-${line}.tgz"
	done
) | tee yarn.ndjson
