pipeline {
  agent any

  environment {
    AWS_REGION = "ap-south-1"
    CLUSTER_NAME = "petclinic-cluster"
  }

  stages {

    // ✅ Clean workspace (fix git issue)
    stage('Clean Workspace') {
      steps {
        deleteDir()
      }
    }

    // ✅ Checkout using Jenkins Git (best practice)
    stage('Git Checkout') {
      steps {
        git branch: 'main' , url: 'https://github.com/manoj723529/spring-petclinic.git'
      }
    }

    // -------------------------
    // TERRAFORM INIT
    // -------------------------
    stage('Terraform Init') {
      steps {
        dir('terraform') {
          sh 'terraform init -upgrade'
        }
      }
    }

    // -------------------------
    // TERRAFORM PLAN
    // -------------------------
    stage('Terraform Plan') {
      steps {
        dir('terraform') {
          sh 'terraform plan'
        }
      }
    }

    // -------------------------
    // TERRAFORM APPLY
    // -------------------------
    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          sh 'terraform apply -auto-approve'
        }
      }
    }

  }
}
