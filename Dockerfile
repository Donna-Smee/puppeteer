FROM node:18-slim

# Install necessary dependencies for Puppeteer and Chromium
RUN apt-get update && apt-get install -y \
    libgbm1 \
    libxss1 \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libxcomposite1 \
    libxrandr2 \
    libxi6 \
    libgdk-pixbuf2.0-0 \
    libnss3 \
    libx11-xcb1 \
    libgconf-2-4 \
    libgdk-x11-2.0-0 \
    libnspr4 \
    && rm -rf /var/lib/apt/lists/*

# Install Puppeteer
WORKDIR /app
COPY ./package.json ./package-lock.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Set the environment variable for Puppeteer to run headless
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

# Start the application
CMD ["node", "trigger_errors.js"]
