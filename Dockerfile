# Використовуємо офіційний образ Nginx в якості бази
FROM nginx:latest

RUN apt-get update && apt-get install -y git && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN git clone https://github.com/mavi-fiot/IITLR45v3ins.git /tmp/IITLR45v3ins

RUN cp -r /tmp/IITLR45v3ins/* /usr/share/nginx/html/

RUN rm -rf /tmp/IITLR45v3ins
