#install all depedencies and npm run build phase
# ---- build stage ----
FROM public.ecr.aws/docker/library/node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# ---- runtime stage ----
FROM public.ecr.aws/nginx/nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
# (Optional SPA routing)
# RUN printf 'server { listen 80; server_name _; root /usr/share/nginx/html; index index.html; location / { try_files $uri /index.html; } }' > /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]