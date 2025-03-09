# Use the official Node.js image
FROM node:16-slim

# Set working directory inside the container
WORKDIR /app

# Install necessary dependencies for Puppeteer and Chromium
RUN apt-get update && apt-get install -y \
  wget \
  ca-certificates \
  fonts-liberation \
  libappindicator3-1 \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libdbus-1-3 \
  libgdk-pixbuf2.0-0 \
  libnspr4 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  xdg-utils \
  libgbm1 \  
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Install Puppeteer dependencies
COPY ./package.json ./package-lock.json ./
RUN npm install

# Copy the Puppeteer script into the container
COPY trigger_errors.js /app/

# Set the entry point to run the Puppeteer script
ENTRYPOINT ["node", "trigger_errors.js"]

# Expose the port (optional, not needed for Puppeteer itself)
EXPOSE 5000
