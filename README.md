# Migrating from Heroku to AWS EC2 with Docker

## Setup docker on the EC2 server
```
sudo yum update -y
sudo yum install git
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-`uname -s`-`uname -m` | sudo tee /usr/local/bin/docker-compose > /dev/null
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```
## Install Docker and clone repo
```
cd /var
sudo mkdir www
sudo mkdir aws-ec2-docker-rails-app
sudo chown -R ec2-user aws-ec2-docker-rails-app
git clone https://github.com/cbdileo/aws-ec2-docker-rails-app.git
cd aws-ec2-docker-rails-app
```

# Create Docker container and start them
```
docker-compose build
docker-compose up -d
```
