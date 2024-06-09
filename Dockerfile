# Використовуємо офіційний образ Nginx в якості бази

# Використовуємо офіційний образ Nginx в якості бази
FROM nginx:latest

# Копіюємо конфігураційний файл Nginx у відповідну директорію контейнера
COPY nginx.conf /etc/nginx/nginx.conf

# Копіюємо  статичні файли у директорію Nginx, яка містить вашу статику
COPY /usr/share/nginx/html /usr/share/nginx/html

# Вказуємо, на якому порту запускати Nginx
EXPOSE 80

# Команда, яка запускає Nginx при старті контейнера
CMD ["nginx", "-g", "daemon off;"]


# FROM nginx:latest

# RUN apt-get update && apt-get install -y git

# RUN git clone https://github.com/mavi-fiot/IITLR45v3ins.git /tmp/IITLR45v3ins

# RUN cp -r /tmp/IITLR45v3ins/* /usr/share/nginx/html/

# RUN rm -rf /tmp/IITLR45v3ins

# COPY nginx.conf /etc/nginx/nginx.conf
# # COPY index.html /usr/share/nginx/html/
# # COPY styles.css /usr/share/nginx/html/


# # Вказуємо EXPOSE на порт 8040, на якому буде працювати Nginx
# # EXPOSE 80
# # CMD ["nginx", "-g", "daemon off;"]
