# Using Node.js 16 as the base image
FROM node:16-alpine

# Setting up the working directory
WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copying the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Installation of npm dependency
RUN npm install

# Copy the application code
COPY . .
# Ensure appuser has permissions to write to /app
RUN chown -R appuser:appgroup /app
USER appuser
# Building of the React app
RUN npm run build

# Expose port 3000 to access app
EXPOSE 3000

# Start your Node.js server
CMD ["npm", "start"]
