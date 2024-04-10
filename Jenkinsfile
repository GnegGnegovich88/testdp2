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
                    def customImage = docker.build("my-docker-image:latest")
                }
            }
        }

        stage('Build project') {
            steps {
                script {
                    docker.image('my-docker-image:latest').inside {
                        sh 'cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release && cmake --build _build --target package'
                    }
                }
            }
        }

        stage('List artifacts') {
            steps {
                sh 'ls -la _build/linux/debian/*.deb'
            }
        }
    }
}
