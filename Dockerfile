## ORIG VERSION WITH RUST


# FROM alpine:3.17

# RUN apk update
# RUN apk add --no-cache tini && \
#     rm -f /var/cache/apk/*

# ARG ARCH
# ADD ./bitclock/target/${ARCH}-unknown-linux-musl/release/bitclock /usr/local/bin/bitclock
# RUN chmod +x /usr/local/bin/bitclock
# ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
# RUN chmod a+x /usr/local/bin/docker_entrypoint.sh







### VERION 2

# # Set base image
# FROM node:14-buster-slim as base

# # Set working directory
# WORKDIR /app

# # Install dependencies
# COPY bitclock/package.json bitclock/package-lock.json ./
# RUN npm ci

# # Copy application files
# COPY bitclock .

# # Set entrypoint
# COPY docker_entrypoint.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/docker_entrypoint.sh
# ENTRYPOINT ["docker_entrypoint.sh"]

# # Expose application port
# EXPOSE 3000





# ##### MULTI-STAGE BECAUSE I NEED PYTHON???...

# # Stage 1: Build
# FROM node:14-buster AS build
# WORKDIR /app

# # Install Python and other build dependencies
# RUN apt-get update && \
#     apt-get install -y python3 g++ make

# # Install dependencies
# COPY bitclock/package.json bitclock/package-lock.json ./
# RUN npm ci

# # Copy application files
# COPY bitclock/. .

# # Build the application
# RUN npm run build

# # Stage 2: Runtime
# FROM node:14-buster-slim
# WORKDIR /app

# # Copy dependencies and build output from the build stage
# COPY --from=build /app/node_modules /app/node_modules
# COPY --from=build /app/dist /app/dist

# # Expose the application port
# EXPOSE 3000

# # Start the application
# CMD ["npm", "start"]




## 404 error happened and this fixes it?

# # Stage 1: Build
# FROM node:14-buster AS build
# WORKDIR /app

# # Install Python and other build dependencies
# RUN apt-get update && \
#     apt-get install -y python3 g++ make \
#     libcairo2-dev libjpeg-dev libpango1.0-dev libgif-dev build-essential

# # Install dependencies
# COPY bitclock/package.json bitclock/package-lock.json ./
# RUN npm ci

# # Copy application files
# COPY bitclock/. .

# # Build the application
# # TODO do I need this?
# # RUN npm run build


# # Stage 2: Final image
# FROM node:14-buster-slim
# WORKDIR /app

# # Copy the node_modules from the build stage
# COPY --from=build /app/node_modules /app/node_modules

# # Copy the application files from the build stage
# COPY --from=build /app /app

# # Expose the application port
# EXPOSE 3000

# # Start the application
# CMD ["npm", "start"]



### jmmm

# # Stage 1: Build
# FROM node:14-buster AS build
# WORKDIR /app

# # Install other build dependencies
# RUN apt-get update && \
#     apt-get install -y g++ make \
#     libcairo2-dev libjpeg-dev libpango1.0-dev libgif-dev build-essential

# # Install dependencies
# COPY bitclock/package.json bitclock/package-lock.json ./
# RUN npm ci

# # Copy application files
# COPY bitclock/. .

# # Build the application if needed (e.g., transpile TypeScript or other build steps)
# # RUN npm run build

# # Stage 2: Final image
# FROM node:14-buster-slim
# WORKDIR /app

# # Copy the node_modules from the build stage
# COPY --from=build /app/node_modules /app/node_modules

# # Copy the application files from the build stage
# COPY --from=build /app /app

# # Expose the application port
# EXPOSE 3000

# # Set tini as the entry point
# ENTRYPOINT ["/usr/bin/tini", "--"]

# # Start the application
# CMD ["npm", "start"]



# Stage 1: Build
FROM node:14-buster AS build
WORKDIR /app

# Install other build dependencies
RUN apt-get update && \
    apt-get install -y g++ make \
    libcairo2-dev libjpeg-dev libpango1.0-dev libgif-dev build-essential

# Install dependencies
COPY bitclock/package.json bitclock/package-lock.json ./
RUN npm ci

# Copy application files
COPY bitclock/. .

# Build the application if needed (e.g., transpile TypeScript or other build steps)
# RUN npm run build

# Stage 2: Final image
FROM node:14-buster-slim
WORKDIR /app

# Install tini
RUN apt-get update && apt-get install -y tini

# Copy the node_modules from the build stage
COPY --from=build /app/node_modules /app/node_modules

# Copy the application files from the build stage
COPY --from=build /app /app

# Copy the entrypoint.sh script
ADD docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/docker_entrypoint.sh

# Expose the application port
EXPOSE 3000

# Set the entrypoint.sh script as the entry point
# ENTRYPOINT ["./docker_entrypoint.sh"]
# ENTRYPOINT ["/app/docker_entrypoint.sh"]
