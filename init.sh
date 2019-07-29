#!/bin/bash

##### Install pip
install_pip() {
    sudo yum install -y epel-release python-pip python-devel PyYAML python-wheel
    sudo pip install --upgrade pip
    sudo pip install setuptools --upgrade
    sudo pip uninstall docker docker-py docker-compose
}

install_docker-compose() {
    sudo python setup.py install
    sudo python setup.py build
}

#### Warning: we have to modify /usr/lib/python2.7/site-packages/docker-4.0.2-py2.7.egg/docker
post_process() {
    DOCKER_PY=/usr/lib/python2.7/site-packages/docker-4.0.2-py2.7.egg/
    DOCKER_COMPOSE_PY=/usr/lib/python2.7/site-packages/docker_compose-1.25.0.dev0-py2.7.egg/
    sudo rm -rf $DOCKER_PY $DOCKER_COMPOSE_PY
    git clone https://github.com/mkwon0/docker-py-swap.git
    git clone https://github.com/mkwon0/docker-compose-py-swap.git
    sudo mv docker-py-swap $DOCKER_PY
    sudo mv docker-compose-py-swap $DOCKER_COMPOSE_PY
    sudo cp bin/docker-compose /usr/local/bin/ 
}

main() {
    install_pip
    install_docker-compose
    post_process
}

main
