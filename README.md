# nodejs-flake

`npm` and `yarn` versions that respect your environment provided `node`.

Assuming:

* You have a `/usr/bin/env`;
* You want a nix flake package of `npm` or `yarn`;
* You want a fixed, specific version of `npm` or `yarn`, that is not the one bundled in your `nodejs` package;
* You want that the fixed version of `npm` or `yarn` to use the same `node` that you have on your `$PATH` environment;
* You somehow locked your `node` somewhere else:
  * nix flakes;
  * jetpack-io/devbox;
  * volta;
  * pnpm;

This might fit your bill.
