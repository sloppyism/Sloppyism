# Base Image: Neko Firefox (Lighter than Chrome for streaming)
FROM m1k1o/neko:firefox

USER root

# 1. Install Networking Tools
RUN apt-get update && \
    apt-get install -y wget socat && \
    rm -rf /var/lib/apt/lists/*

# 2. Force Screen Size (540p for 600kbps speed)
ENV NEKO_SCREEN=960x540@20

# 3. CRITICAL: Force TCP Mode (Fixes Black Screen on Free Tiers)
# This tells Neko "Don't use UDP, use the standard web port"
ENV NEKO_ICELITE=1
ENV NEKO_EPR=30000-30100
ENV NEKO_UDPMUX=30000

# 4. Password Protection
ENV NEKO_PASSWORD=121459
ENV NEKO_PASSWORD_ADMIN=121459

# 5. Bind to the correct port (Render/Koyeb usually use 8080 or 8000)
ENV NEKO_BIND=:8080

EXPOSE 8080
