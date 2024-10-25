pipeline{
    agent any
    stages {
        stage('Checkout from Git'){
            steps{
                git 'https://github.com/lax66/DevOps-Project-Swiggy.git'
            }
        }
        stage("Docker Build"){
            steps{
                sh "docker build -t swiggy ."
                sh "docker tag swiggy laxg66/swiggy:latest "
            }
        }
        
        stage("Docker Push"){
            steps{
                script{
                    withDockerRegistry(credentialsId: 'docker-creds') {
                        sh "docker push laxg66/swiggy:latest "
                    }
                }
            }
        }
        stage("TRIVY"){
            steps{
                sh "trivy image --skip-update laxg66/swiggy:latest > trivy.txt" 
            }
        }
        stage("deploying in k8s"){
            steps{
                withKubeConfig(caCertificate: '', clusterName: 'kubernetes', contextName: '', credentialsId: 'jenkins-k8s', namespace: 'jenkins', restrictKubeConfigAccess: false, serverUrl: 'https://192.168.64.128:6443') {
                    sh 'kubectl apply -f deployment.yaml'
                } 
            }
        }
    }
}
