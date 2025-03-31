pipeline {
  agent any
  stages {
    stage('Terraform checkout') {
      steps {
        checkout scm
      }
    }

    stage('terrroform init') {
      steps {
        script {
          sh 'terrform init'
        }

        tool(name: 'terraform', type: 'terraform')
      }
    }

  }
}