FROM node:16 as builder 
WORKDIR /usr/
COPY package.json ./
RUN npm install
COPY ./ ./
RUN rm -rf node_modules
RUN npm ci --only=production

# Final stage
FROM alpine:latest as production
RUN apk --no-cache add nodejs ca-certificates
WORKDIR /root/
COPY --from=builder /usr/ ./
CMD ["node","/index.js"]