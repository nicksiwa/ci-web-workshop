# build environment
FROM node:8.11.4 AS builder
RUN mkdir /usr/src/ci-web-workshop
WORKDIR /usr/src/ci-web-workshop
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# production environment
FROM nginx:1.16.1-alpine
COPY --from=0 /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
