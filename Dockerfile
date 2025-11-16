# Use the official Hugo image with extended features
FROM hugomods/hugo:exts as builder

# Set working directory
WORKDIR /src

# Copy the entire project
COPY . .

# Build the Hugo site
RUN hugo --minify

# Use nginx to serve the static files
FROM nginx:alpine

# Copy the built site from the builder stage
COPY --from=builder /src/public /usr/share/nginx/html

# Copy a custom nginx configuration if needed
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]