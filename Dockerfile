# Build React App
FROM node:alpine3.18 as build
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Server With Nginx
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /email-app/build .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]