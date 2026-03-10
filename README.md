# trezor-nostr-signer-workshop

## Resources

- [Trezor Firmware](https://github.com/trezor/trezor-firmware)
- [TrezorConnect](https://github.com/trezor/trezor-suite/tree/develop/packages/connect)

## Getting started

Trezor Firmware has in the `main` branch some Nostr features:

- `sign-event`
- `get-npub`

But they are not in the production release yet, so we require a `debug` build, for that we are going to build the Trezor Firmware with `debug` flag and then flash our devices with that firmware.

### Create python build tools environment

Git clone [Trezor Firmware](https://github.com/trezor/trezor-firmware) and then you can use [Nix](https://nixos.org/download/) to get all the dependencies by running:

```bash
nix-shell
```

Once you have the `nix` environment setup you can continue creating the python setup to build the Firmware.

```bash
uv sync
source .venv/bin/activate
```

### Build the firmware with `debug` flag

```bash
TREZOR_MODEL=T3T1 QUIET_MODE=1 PYOPT=0 make -C core clean build_firmware
```

- `PYOPT=0` disables MicroPython bytecode optimization, which enables debug symbols and assertions. The default is `PYOPT=1` (optimized/production).
- The binary will be located at `core/build/firmware/firmware.bin`

### Flash Trezor device with new firmware

- With the CLI tool `trezorctl`

```bash
trezorctl firmware update -f core/build/firmware/firmware.bin
```

- With Trezor Suite at `https://suite.trezor.io/web/settings/device` or using Trezor Suite Desktop

## trezorctl

## Nodejs

## Browser

## Rust
