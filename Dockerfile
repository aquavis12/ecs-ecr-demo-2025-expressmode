# Use nginx alpine for minimal size
FROM nginx:alpine

# Copy HTML files to nginx default directory
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# nginx runs automatically with the default CMD
