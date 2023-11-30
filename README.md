# nodejs-flake

`npm`, `yarn` and `pnpm` versions that respect your environment provided `node`.

Assuming:

* You have a `/usr/bin/env`;
* You want a nix flake package of `npm`, `yarn` or `pnpm`;
* You want a fixed, specific version of `npm`, `yarn` or `pnpm`, that is not the one bundled in your `nodejs` package;
* You want that the fixed version of `npm`, `yarn` or `pnpm` to use the same `node` that you have on your `$PATH` environment;
* You somehow locked your `node` somewhere else:
  * nix flakes;
  * jetpack-io/devbox;
  * volta;
  * pnpm;

This might fit your bill.

## Usage

Pick your `npm`/`yarn`/`pnpm` version. Because of limitations on `nixpkgs pname`s, `period`s and the `at sign` are underlines.

    # let's assume you need npm@9.9.2
    # npm@9.9.2 -> npm-9.9.2 -> npm-9_9_2

    # probably a terrible idea:
    nix --extra-experimental-features 'nix-command flakes' profile install 'github:empjustine/nodejs-flake/v2#npm-9_9_2'

    # a better idea
    devbox add 'github:empjustine/nodejs-flake/v2#npm-9_9_2'
