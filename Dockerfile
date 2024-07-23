# Stage 1: Download the wsbroad binary
FROM --platform=linux/amd64 alpine:latest as downloader

# Install wget and ca-certificates
RUN apk add --no-cache wget ca-certificates

# Download wsbroad
RUN wget https://github.com/vi/wsbroad/releases/download/v0.3.0/wsbroad.x86_64-unknown-linux-musl -O /wsbroad && \
    chmod +x /wsbroad

# Stage 2: Setup the runtime container
FROM scratch

# Copy the wsbroad binary from the downloader stage
COPY --from=downloader /wsbroad /wsbroad

# Set the entrypoint
ENTRYPOINT ["/wsbroad"]

# Default command (can be overridden)
CMD ["--help"]