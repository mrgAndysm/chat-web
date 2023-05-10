# build front-end
FROM node:lts-alpine AS frontend

RUN npm install pnpm -g

WORKDIR /app

COPY ./package.json /app

COPY ./pnpm-lock.yaml /app

RUN pnpm install

COPY . /app

RUN pnpm run build

# Nginx 服务
FROM nginx:stable-alpine as production-stage

# 从上一阶段中复制静态文件
COPY --from=frontend /app/dist /usr/share/nginx/html

# 将配置文件复制到容器中
COPY docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# 暴露 80 端口
EXPOSE 80

# 启动 Nginx 服务
CMD ["nginx", "-g", "daemon off;"]