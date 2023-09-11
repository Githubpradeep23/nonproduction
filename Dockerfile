# Step 1: Build the React application
FROM node:16 AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the local files to the container
COPY . .

# Build the app
RUN npm run build

# Step 2: Serve the React application using `serve`
FROM node:16

WORKDIR /app

# Copy the built app from the previous stage
COPY --from=build /app/build ./build

# Install `serve` to serve the built static files
RUN npm install -g serve

# Expose the port the app runs on
EXPOSE 3000

# Start the app using `serve`
CMD ["serve", "-s", "build", "-l", "3000"]
