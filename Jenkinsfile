pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/GnegGnegovich88/testdp2.git'
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    def image = docker.build("my-docker-image:latest")
                }
            }
        }

        stage('Build project') {
            steps {
                script {
                    docker.image('my-docker-image:latest').inside {
                        sh 'cmake -H. -Bbuild && cmake --build build --target package'
                    }
                }
            }
        }

        stage('List artifacts') {
            steps {
                sh 'ls -la build/*.deb'
            }
        }
    }
}
