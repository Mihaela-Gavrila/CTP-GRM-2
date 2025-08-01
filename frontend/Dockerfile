# Multi-stage build pentru optimizare
FROM node:18-alpine AS build

LABEL maintainer="mihaela.gavrila@student.tuiasi.ro"
LABEL description="GRM 2.0 Frontend Build Stage"
LABEL version="1.0.0"

WORKDIR /app

# Copy doar package files pentru cache optimization
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production --silent

# Copy source code
COPY . .

# Build arguments
ARG REACT_APP_API_URL=http://localhost:8080/api
ARG REACT_APP_VERSION=1.0.0

# Set environment variables
ENV REACT_APP_API_URL=$REACT_APP_API_URL \
    REACT_APP_VERSION=$REACT_APP_VERSION \
    NODE_ENV=production

# Build application
RUN npm run build

# Stage 2: Production cu Nginx
FROM nginx:1.25-alpine AS production

LABEL maintainer="mihaela.gavrila@student.tuiasi.ro"
LABEL description="GRM 2.0 Frontend Production"
LABEL version="1.0.0"

# Install curl pentru health checks
RUN apk add --no-cache curl

# Remove default nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy built application
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create nginx user și permissions
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d

# Switch to nginx user
USER nginx

# Expose port
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
