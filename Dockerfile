FROM node:alpine as builder
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# after copy the build folder, everything else in the
# builder phase is automatically removed (to keep the size small)
COPY --from=builder /app/build /usr/share/nginx/html
# no need to start nginx explicitly 
# because nginx image has already took care of it