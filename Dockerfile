# build environment
FROM node:8.10.0-alpine AS builder
WORKDIR /usr/src/ci-web-workshop
COPY package.json /usr/src/ci-web-workshop
RUN npm install
COPY . .
RUN npm run build

# production environment
FROM nginx:1.16.1-alpine
COPY --from=builder /usr/src/ci-web-workshop/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
