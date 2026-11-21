pipeline {
    agent any

    tools {
        maven 'M2_HOME'
        jdk   'JAVA_HOME'
    }

    triggers {
        pollSCM('* * * * *')
    }

    stages {

        stage('Récupération du code (GitHub)') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/dhifallahaysser/projetdevops.git'
            }
        }

        stage('Tests unitaires') {
            steps {
                sh 'mvn clean test'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Création du livrable') {
            steps {
                sh 'mvn package -DskipTests'
            }
            post {
                success {
                    archiveArtifacts artifacts: 'target/*.jar, target/*.war',
                                     fingerprint: true,
                                     allowEmptyArchive: true
                }
            }
        }
    }

    post {
        success {
            echo 'Build réussi : le livrable est dans le dossier target.'
        }
        failure {
            mail to: 'dhifallah17.aysser@gmail.com',
                 subject: "ÉCHEC du build : ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                 body: """Le build a échoué.

Projet  : ${env.JOB_NAME}
Build   : #${env.BUILD_NUMBER}
Détails : ${env.BUILD_URL}console
"""
        }
    }
}