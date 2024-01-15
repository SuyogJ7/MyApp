# Stage 1: Build the React app
FROM node:14 AS build
WORKDIR /app

# Copy only the package.json and package-lock.json files first to leverage Docker cache
COPY client/package*.json ./

# Install dependencies using npm
RUN npm install

# Copy the entire application source
COPY client .

# Ensure react-scripts is installed globally
RUN npm install -g react-scripts

# Build the React app
RUN npm run build

# Stage 2: Create the production image
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]






