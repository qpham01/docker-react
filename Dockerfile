# Step 1
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Build folder is /app/build
# From https://hub.docker.com/_/nginx, the default folder for nginx is /usr/share/nginx/html
# We'll need to copy the build folder's content there

# Step 2
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# Nginx container already automatically start nginx so no other command is needed.