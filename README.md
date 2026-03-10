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

If you setup your environment in the `Trezor Firmware` repository then `trezorctl` should be available for you.

```bash
trezorctl firmware update -f core/build/firmware/firmware.bin
```

- With Trezor Suite at `https://suite.trezor.io/web/settings/device` or using Trezor Suite Desktop

## Initialize device

- With `trezorctl`:

```bash
trezorctl device setup
```

- With [Trezor Suite](https://suite.trezor.io/web/)

## Running Trezor for Nostr

### With `trezorctl`

- Get your nostr public key

```bash
trezorctl nostr get-pubkey -a 0
```

- Sign a nostr event

```bash
### sign-event
trezorctl nostr sign-event '{"created_at": 1234567890, "kind": 1, "tags": [], "content": "Hello Nostr!"}'
```

The JSON needs these fields:

- **`created_at`** — Unix timestamp (int)
- **`kind`** — event kind (int, e.g. `1` for text note)
- **`tags`** — array of arrays (e.g. `[["e", "event_id"], ["p", "pubkey"]]`)
- **`content`** — the event content string

Use `-a` to specify a different account index (defaults to `0`, which maps to `m/44'/1237'/0'/0/0`):

### With JavaScript (Nodejs)

### With Rust
