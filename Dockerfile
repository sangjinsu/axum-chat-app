# 1️⃣ 빌드 스테이지
FROM rust:1.87-slim-bookworm AS builder

# 필요한 패키지 설치
RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config libssl-dev ca-certificates curl build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .
RUN cargo build --release --bin docker

# 2️⃣ 실행 스테이지
FROM debian:bookworm-slim

# 인증서만 필요
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /app/target/release/docker ./app
COPY --from=builder /app/static ./static
COPY --from=builder /app/.env .env

ENTRYPOINT ["./app"]