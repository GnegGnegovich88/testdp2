pipeline {
    agent any

    parameters {
        string(name: 'BRANCH', defaultValue: 'master', description: 'Select the branch to build')
    }

    stages {
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker image') {
            steps {
                script {
                    dockerImage = docker.build("my-docker-image")
                }
            }
        }

        stage('Build project') {
            steps {
                script {
                    docker.image("my-docker-image").inside {
                        sh '''
                            apt-get update && apt-get install -y build-essential
                            cd freerdp2/
                            dpkg-buildpackage -b -us -uc
                        '''
                    }
                }
            }
        }

        stage('List artifacts') {
            steps {
                sh 'ls -la freerdp2/../*.deb'
            }
        }
    }
}

