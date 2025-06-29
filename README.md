# 🧩 Axum Chat App (Dockerized)

Rust + Axum 기반의 실시간 채팅 서버입니다. WebSocket을 통한 실시간 메시지 송수신, RESTful API 기반 사용자 및 채팅방 관리, PostgreSQL 데이터베이스 연동, Docker 환경을 통한 로컬 개발 및 배포 구성을 제공합니다.

## 🚀 주요 기능

- ✅ 채팅방 생성/조회/수정/삭제 (REST API)
- ✅ 채팅 메시지 송수신 (WebSocket)
- ✅ 사용자 CRUD 기능 (REST API)
- ✅ tokio 채널 기반 실시간 브로드캐스트
- ✅ PostgreSQL + SeaORM 기반 DB 연동
- ✅ Docker + Compose를 통한 로컬 개발환경 구성

## 🗂 폴더 구조

```
.
├── src/
│   └── api/
│       ├── chat.rs         # WebSocket 채팅 처리
│       ├── chat_room.rs    # 채팅방 API
│       ├── user.rs         # 사용자 API
│       ├── state.rs        # AppState (DB, broadcast)
│       └── mod.rs          # API 라우터 통합
├── main_docker.rs          # Docker 환경 실행 진입점
├── Dockerfile              # Rust 앱 빌드 및 실행 설정
├── docker-compose.yml      # 앱 + PostgreSQL 통합 실행 구성
├── .env                    # 환경 변수 파일
```

## ⚙️ 사용 기술

| 기능             | 기술명                                      |
|------------------|----------------------------------------------|
| 웹 프레임워크     | [Axum](https://github.com/tokio-rs/axum)     |
| ORM              | [SeaORM](https://www.sea-ql.org/SeaORM/)     |
| DB               | PostgreSQL 16                                |
| 비동기 런타임     | Tokio                                        |
| 메시지 브로드캐스트 | tokio `broadcast::channel`                  |
| 배포 환경         | Docker, Docker Compose                       |
| 개발 실행 옵션     | Shuttle Runtime 지원                         |

## 📦 API 요약

### 🧑 사용자 API

- `GET /users/:id` - 유저 정보 조회
- `POST /users` - 유저 생성
- `PUT /users/:id` - 유저 수정
- `DELETE /users/:id` - 유저 삭제

### 💬 채팅방 API

- `GET /chat_rooms/:id` - 채팅방 정보 조회
- `POST /chat_rooms` - 채팅방 생성
- `PUT /chat_rooms/:id` - 채팅방 수정
- `DELETE /chat_rooms/:id` - 채팅방 삭제

### 🔌 채팅 메시지 API

- `GET /chat/:room_id` - WebSocket 접속
- `POST /chat/:room_id` - 메시지 발행

## 🐳 Docker Compose 사용법

### `.env` 예시

```env
POSTGRES_DB=chat_app
POSTGRES_USER=postgres
POSTGRES_PASSWORD=yourpassword
DATABASE_URL=postgres://postgres:yourpassword@db:5432/chat_app
RUST_LOG=debug
```

### 실행

```bash
docker compose up --build
```

### 서비스 구성

| 서비스 | 설명                  | 포트         |
|--------|-----------------------|--------------|
| app    | Rust 기반 웹 서버      | 3000 → 3000  |
| db     | PostgreSQL 16 DB       | 5432 → 5432  |

## 🧪 개발 실행 (Shuttle 사용 시)

```bash
shuttle run --port 3000
```

## ✅ 향후 개선 아이디어

- [ ] JWT 기반 인증 시스템 추가
- [ ] Redis Pub/Sub 도입 통한 확장성 강화
- [ ] 채팅 메시지 DB 영속화
- [ ] WebSocket 세션 관리 강화 (타임아웃, 핑 등)
