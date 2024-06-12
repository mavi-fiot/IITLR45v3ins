provider "aws" {
  region = "us-east-2"
  shared_credentials_files = ["C:/Users/MAVi/.aws/credentials"]
}

resource "aws_instance" "lr6ver2" {
    ami           = "ami-01abb191f665c021f"
    instance_type = "t2.micro"
    key_name      = "lr45v4"
    # user_data     = file("config.sh")
    user_data=<<EOF
#!/bin/bash

sudo apt update
sudo apt install -y python3-pip

# Додавання ключа Docker 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Додавання Docker 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Запуск і активація служби Docker
sudo systemctl start docker
sudo systemctl enable docker

# Встановлення Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Додавання користувача до групи Docker
sudo usermod -aG docker ubuntu

# Перезавантаження групи для поточного сеансу
newgrp docker <<SHELL
# Клонування репозиторію
git clone https://github.com/mavi-fiot/IITLR45v3ins.git

# Перехід до папки з файлами Git репозиторію
cd IITLR45v3ins

# Виконання Docker Compose build
docker-compose build

# Запуск у фоновому режимі Docker Compose up
docker-compose up -d
SHELL
EOF

  
    tags = {
        Name = "lr6ver2"
    }

    # Встановлення публічного IP-адреси
    associate_public_ip_address = true

    # Зв'язування з безпечною групою
    vpc_security_group_ids = [aws_security_group.lr6_security_group.id]
}

# Опис мережевих ресурсів
resource "aws_vpc" "example_vpc" {
    cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example_subnet" {
    vpc_id     = aws_vpc.example_vpc.id
    cidr_block = "10.0.1.0/24"
}

# Опис правил файрвола
resource "aws_security_group" "lr6_security_group" {
    name        = "lr6-security-group"
    description = "Allow inbound traffic on port 80"
  
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 8030
        to_port     = 8030
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "lr6sg"
    }

}

