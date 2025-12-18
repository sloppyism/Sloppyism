# 1. Base Image: Neko Firefox (Most stable on Cloud)
# Chrome crashes more often on free tiers due to memory limits.
FROM m1k1o/neko:firefox

USER root

# 2. Install Tools (Basic networking)
RUN apt-get update && \
    apt-get install -y wget socat && \
    rm -rf /var/lib/apt/lists/*

# 3. FIX THE CRASH: Use V3 Configs & Safe Resolution
# The old "NEKO_SCREEN" caused the driver error.
# We use 1280x720 because it is a standard VESA mode that never fails.
ENV NEKO_DESKTOP_SCREEN="1280x720@30"

# 4. Networking Fixes (For Koyeb Firewall)
# Force Neko to bind to the port Koyeb expects (8000 or 8080)
ENV NEKO_SERVER_BIND=":8000"

# "WebRTC IceLite" - Critical for servers behind firewalls (prevents black screen)
ENV NEKO_WEBRTC_ICELITE=1

# Define a small port range for audio/video to help it tunnel
ENV NEKO_WEBRTC_EPR="59000-59100"
ENV NEKO_WEBRTC_UDPMUX=59000

# 5. Passwords (V3 Format)
ENV NEKO_MEMBER_PROVIDER="multiuser"
ENV NEKO_MEMBER_MULTIUSER_USER_PASSWORD="121459"
ENV NEKO_MEMBER_MULTIUSER_ADMIN_PASSWORD="121459"

# 6. Expose the Port
EXPOSE 8000
