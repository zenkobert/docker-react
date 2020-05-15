# FROM node:alpine as builder
FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html
# COPY --from=builder /app/build /usr/share/nginx/html

# after copy the build folder, everything else in the
# builder phase is automatically removed (to keep the size small)

# no need to start nginx explicitly 
# because nginx image has already took care of it