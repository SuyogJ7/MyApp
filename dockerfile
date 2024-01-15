# Dockerfile
# Stage 1: Build the React app
FROM node:14 AS build
WORKDIR /app
COPY client/package*.json ./
RUN npm install
COPY client .
RUN npm run build

# Stage 2: Create the production image
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

