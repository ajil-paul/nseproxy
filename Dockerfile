FROM rust:1.62 as build

WORKDIR /app
COPY . .

RUN cargo build --release

FROM debian:buster-slim
RUN apt-get update && apt-get install -y libgssapi-krb5-2 && rm -rf /var/lib/apt/lists/*
COPY --from=build /app/target/release/nseproxy /usr/local/bin/nseproxy

EXPOSE 3000
CMD ["nseproxy"]
