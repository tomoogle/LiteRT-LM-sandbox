# Use Ubuntu 22.04 LTS as the base for a stable, modern C++ toolchain
FROM docker.io/library/ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential build tools and dependencies
# Note: libpng is explicitly removed because it is built hermetically via CMake
RUN apt-get update && apt-get install -y \
    build-essential \
    ninja-build \
    git \
    pkg-config \
    python3 \
    python3-pip \
    openjdk-17-jre-headless \
    libasound2-dev \
    wget \
    curl \
    unzip \
    gpg \
    ca-certificates \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install modern CMake from Kitware repository
# Ubuntu 22.04 defaults to CMake 3.22; this ensures we get 3.30+ if needed
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null \
    | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \
    && echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' \
    | tee /etc/apt/sources.list.d/kitware.list >/dev/null \
    && apt-get update && apt-get install -y cmake \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Optional: Setup non-root user (Uncomment if needed for specific permissions)
# ARG USER_ID=1000
# ARG GROUP_ID=1000
# RUN groupadd -g ${GROUP_ID} dev && \
#     useradd -m -u ${USER_ID} -g dev -s /bin/bash dev

WORKDIR /litert_lm

# Clone the repository and checkout the working branch
RUN git clone https://github.com/tomoogle/LiteRT-LM-sandbox.git . \
    && git checkout dev

# Default command
CMD ["/bin/bash"]