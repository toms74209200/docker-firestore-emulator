# docker-firestore-emulator

![GitHub tag (with filter)](https://img.shields.io/github/v/tag/toms74209200/docker-firestore-emulator)
[![Build and upload image](https://github.com/toms74209200/docker-firestore-emulator/actions/workflows/build_image.yml/badge.svg)](https://github.com/toms74209200/docker-firestore-emulator/actions/workflows/build_image.yml)

Firestore Emulator Docker image

## Usage

Mount Firestore configuration files from host and launch it. By default, it launches in `/firestore`.

```bash
$ docker run --rm -p8080:8080 -v$(pwd):/firestore ghcr.io/toms74209200/docker-firestore-emulator
┌─────────────────────────────────────────────────────────────┐
│ ✔  All emulators ready! It is now safe to connect your app. │
└─────────────────────────────────────────────────────────────┘

┌───────────┬──────────────┐
│ Emulator  │ Host:Port    │
├───────────┼──────────────┤
│ Firestore │ 0.0.0.0:8080 │
└───────────┴──────────────┘
```

You can check that launch successfully, by accessing `http://localhost:8080`.

```bash
$ curl http://localhost:8080
OK
```

To use the Emulator UI, you need to specify the project ID.

```bash
$ docker run --rm -p8080:8080 -p4000:4000 -v$(pwd):/firestore ghcr.io/toms74209200/docker-firestore-emulator "emulators:start" "--only" "firestore" "--project" "demo"
┌─────────────────────────────────────────────────────────────┐
│ ✔  All emulators ready! It is now safe to connect your app. │
│ i  View Emulator UI at http://127.0.0.1:4000/               │
└─────────────────────────────────────────────────────────────┘

┌───────────┬──────────────┬─────────────────────────────────┐
│ Emulator  │ Host:Port    │ View in Emulator UI             │
├───────────┼──────────────┼─────────────────────────────────┤
│ Firestore │ 0.0.0.0:8080 │ http://127.0.0.1:4000/firestore │
└───────────┴──────────────┴─────────────────────────────────┘
```

**`docker-compose.yml`**
```yaml
services:
  firestore:
    image: ghcr.io/toms74209200/docker-firestore-emulator
    command: ["emulators:start", "--only", "firestore", "--project", "demo"]
    ports:
      - "8080:8080"
      - "4000:4000"
    volumes:
      - .:/firestore
```

## License

[MIT License](LICENSE)

## Author

[toms74209200](<https://github.com/toms74209200>)
