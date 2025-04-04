pipeline {
agent {label 'google-cloud'}

environment {
GCP_PROJECT_ID = 'core-project-448210' // Replace with your GCP project ID
REPO_NAME = 'myinfra' // Replace with your repo name
GITHUB_REPO = 'https://github.com/myvijay2345/Jenkin-test/edit/main/Jenkinsfile' // Replace with your GitHub repo URL
GCP_SERVICE_ACCOUNT = credential('GCP_CORE_KEY_JENKINS') // Path to your GCP service account key
}

stages 
{
 stage('Clone Google Cloud Source Repository') 
 {
  steps {
   script {
    // Authenticate with Google Cloud
    sh 'gcloud auth activate-service-account --key-file=${GCP_SERVICE_ACCOUNT}'
    // Clone the repository
    sh "gcloud source repos clone --project= GCP_PROJECT_ID"
         }
        }
}   

stage('Push to GitHub') 
{
    steps {
    script {
    // Navigate to the cloned repository
    dir(REPO_NAME) {
    // Add GitHub remote
    sh "git remote add github "
    // Push to GitHub
    sh 'git push github main' // Change 'main' to your branch if necessary
                    }
            }              
        }
 }
}
}
