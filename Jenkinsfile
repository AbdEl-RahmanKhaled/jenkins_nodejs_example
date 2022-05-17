pipeline {
    agent { label 'private' }

    environment {
        OLD_TAG="1.1"
        NEW_TAG="1.1"
        IMG_NAME="abdelrahmankha/node-app"
        APP_NAME = "node-app"
    }

    stages {
        stage('build') {
           steps {
                echo 'Building Docker image...'
                catchError {
                    sh "docker stop ${APP_NAME}"
                    sh "docker rm -f ${APP_NAME}"
                    sh "docker rmi -f ${IMG_NAME}:${OLD_TAG}"
                }                   
                sh "docker build -t ${IMG_NAME}:${NEW_TAG} ."
           }
       }
       stage('deploy') {
           steps {
               script {
                    echo 'deploying image....'
                    withCredentials([usernamePassword(credentialsId: 'rds_cred', usernameVariable: 'USERNAME', passwordVariable: 'PASS')]) {
                        sh "docker run -d --name ${APP_NAME} --env-file $HOME/.env -e RDS_USERNAME=${USERNAME} -e RDS_PASSWORD=${PASS} -p3000:3000 ${IMG_NAME}:${NEW_TAG}"
                    }
               }
            }
        }
       stage('Push to Dockerhub'){
           steps {
               echo 'pushing to dockerhub repo...'
                withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'USERNAME', passwordVariable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u $USERNAME --password-stdin'
                    sh "docker push ${IMG_NAME}:${NEW_TAG}"
                }
           }

           post {
                success {
                    slackSend(channel: "test", message: "The App has deployed successfully", sendAsText: false)
                }
            }
       }
       
    }
}
