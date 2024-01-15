# Stage 1: Build the React app
FROM node:14 AS build
WORKDIR /app

# Copy only the package.json and yarn.lock files first to leverage Docker cache
COPY client/package*.json ./
COPY client/yarn.lock ./

# Install dependencies
RUN npm install -g yarn
RUN yarn install

# Copy the entire application source
COPY client .

# Ensure react-scripts is installed globally
RUN yarn global add react-scripts

# Build the React app
RUN yarn build

# Stage 2: Create the production image
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]





