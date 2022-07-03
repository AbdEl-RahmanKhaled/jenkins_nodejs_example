pipeline {
    agent any

    environment {
        OLD_TAG="1.0"
        NEW_TAG="1.0"
        IMG_NAME="repository/node-app/node-app-k8s"
        APP_NAME = "node-app"
        NEXUS_REPO = "192.168.49.2:30081"
    }

    stages {
        stage('build') {
           steps {
                echo 'Building Docker image...'
                catchError {
                    sh "docker stop ${APP_NAME}"
                    sh "docker rm -f ${APP_NAME}"
                }  
                catchError {
                    sh "docker rmi -f ${NEXUS_REPO}/${IMG_NAME}:${OLD_TAG}"
                }                   
                sh "docker build -t ${NEXUS_REPO}/${IMG_NAME}:${NEW_TAG} ."
           }
       }
       stage('Push to Nexus'){
           steps {
               echo 'pushing to Nexus repo...'
                withCredentials([usernamePassword(credentialsId: 'nexus', usernameVariable: 'USERNAME', passwordVariable: 'PASS')]) {
                    sh "echo $PASS | docker login ${NEXUS_REPO} -u $USERNAME --password-stdin"
                    sh "docker push ${NEXUS_REPO}/${IMG_NAME}:${NEW_TAG}"
                }
           }
       }
       
    }
}