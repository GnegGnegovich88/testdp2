pipeline {
    agent any

    environment {
        GIT_BRANCH = 'main'
        DOCKER_IMAGE = 'my-build-image'
    }

    stages {
        stage('Clone repository') {
            steps {
                git branch: env.GIT_BRANCH, url: 'https://github.com/GnegGnegovich88/testdp2.git'
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    dockerImage = docker.build(env.DOCKER_IMAGE)
                }
            }
        }

        stage('Build project') {
            steps {
                script {
                    docker.image(env.DOCKER_IMAGE).inside {
                        sh 'cmake -H. -Bbuild && cmake --build build && fakeroot dpkg-buildpackage -b -us -uc'
                    }
                }
            }
        }

        stage('List artifacts') {
            steps {
                sh 'ls -la *.deb'
            }
        }
    }
}
