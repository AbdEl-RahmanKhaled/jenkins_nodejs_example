pipeline {
    agent any

    environment {
        OLD_TAG="1.0"
        NEW_TAG="1.0"
        IMG_NAME="node-app-k8s"
        APP_NAME = "node-app"
        NEXUS_REPO = "10.107.185.142:8082"
    }

    stages {
        stage('build') {
           steps {
                echo 'Building Docker image...'
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
       
       stage('test'){
           steps {
                withCredentials([usernamePassword(credentialsId: 'nexus', usernameVariable: 'USERNAME', passwordVariable: 'PASS')]) {
                    // sh './kubernetes/secrets-configmaps/token.sh'
                    sh "kubectl create secret -n dev docker-registry nexus-cred --docker-server=10.107.185.142:8082 --docker-username=$USERNAME --docker-password=$PASS"
                    sh 'kubectl apply -f ./kubernetes/pods-deployments/app-deployment.yaml'
                }
           }
       }
    }
}