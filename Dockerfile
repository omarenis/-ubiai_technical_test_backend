FROM debian:10
RUN apt-get -y update && apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git wget tar make
RUN apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev
RUN apt-get install -y build-essential
WORKDIR /opt
RUN wget https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz
RUN tar xzf Python-3.8.12.tgz
RUN ls
WORKDIR /opt/Python-3.8.12
RUN ls -ls
RUN bash ./configure --enable-optimizations
RUN make altinstall 
WORKDIR /backend
COPY . .
RUN python3.8 -m pip install -r requirements.txt
RUN python3.8 /backend/manage.py makemigrations && python3.8 /backend/manage.py migrate
RUN python3.8 /backend/manage.py runserver
EXPOSE 8000
