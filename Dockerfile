# Stage 1: Build the React app
FROM node:20-alpine


WORKDIR /app

COPY package.json ./
COPY yarn.lock ./

RUN yarn install 

COPY . ./

RUN yarn build

# Stage 2: Serve the app with Nginx
FROM nginx:1.19.10-alpine

# Copy the built React app from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Copy the custom Nginx configuration
COPY --from=build /app/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Expose the ports for HTTP and HTTPS
EXPOSE 80
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]



