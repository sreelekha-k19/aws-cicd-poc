node {
    stage("Git Clone"){

        git credentialsId: 'git-credentials', url: 'https://github.com/vinayakpadukone/mypfrepo.git'
    
    stage("Docker build"){
        //sh 'docker version'
        // sh 'docker rmi vinayakpadukone/resume:latest'
        sh 'docker build --no-cache -t resume .'
        sh 'docker tag resume vinayakpadukone/resume:$BUILD_NUMBER'
        // sh 'docker tag resume vinayakpadukone/resume:latest'
    }

    withCredentials([string(credentialsId: 'docker-credentials', variable: 'PASSWORD')]) {
        sh 'docker login -u vinayakpadukone -p $PASSWORD'
    }

    stage("Push Image to Docker Hub"){
        sh 'docker push  vinayakpadukone/resume:$BUILD_NUMBER'
        // sh 'docker push  vinayakpadukone/resume:latest'
    }
    
    stage("kubernetes deployment"){
        sh 'sed -i "s/_BUILD_NUMBER_/${BUILD_NUMBER}/" deploymentservice.yaml'
        sh 'kubectl apply -f deploymentservice.yaml'
    }
    stage('CleanUp workspace') {
        sh ' echo CleanUp'
        sh "docker rmi vinayakpadukone/resume:${BUILD_NUMBER}"
        sh "docker rmi resume"
    }
    }
}
