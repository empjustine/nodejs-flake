#!/bin/bash

set -e

: "${out?'missing output path'}" "${package?'missing package derivation'}" "${nodejs?'missing nodejs'}" "${coreutils?'missing coreutils'}" "${findutils?'missing findutils'}"

printf '{}' >package.json
"${coreutils}/bin/mkdir" -p "${out}/lib" "${out}/bin"
"${nodejs}/bin/npm" install --ignore-scripts "$package"
"${coreutils}/bin/cp" -r node_modules "${out}/lib/node_modules"
cd "${out}/bin" || exit 127
"${findutils}/bin/find" ../lib/node_modules/.bin -type l -exec "${coreutils}/bin/ln" -s '{}' ';'
