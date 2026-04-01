pipeline {
  agent any

  environment {
    AWS_REGION = "ap-south-1"
    CLUSTER_NAME = "petclinic-cluster"
    ECR_REPO = "<ECR-URL>/petclinic"
  }

  stages {

    // -------------------------
    // STAGE 1: TERRAFORM INIT
    // -------------------------
    stage('Terraform Init') {
      steps {
        dir('terraform') {
          sh 'terraform init'
        }
      }
    }

    // -------------------------
    // STAGE 2: TERRAFORM PLAN
    // -------------------------
    stage('Terraform Plan') {
      steps {
        dir('terraform') {
          sh 'terraform plan'
        }
      }
    }

    // -------------------------
    // STAGE 3: TERRAFORM APPLY
    // -------------------------
    stage('Terraform Apply') {
      steps {
        dir('terraform') {
          sh 'terraform apply -auto-approve'
        }
      }
    }

    // -------------------------
    // STAGE 4: BUILD APP
    // -------------------------
    stage('Build') {
      steps {
        dir('app') {
          sh 'mvn clean package -DskipTests'
        }
      }
    }

    // -------------------------
    // STAGE 5: DOCKER BUILD
    // -------------------------
    stage('Docker Build') {
      steps {
        dir('app') {
          sh 'docker build -t petclinic-app .'
        }
      }
    }

    // -------------------------
    // STAGE 6: PUSH TO ECR
    // -------------------------
    stage('Push to ECR') {
      steps {
        sh '''
        aws ecr get-login-password --region $AWS_REGION | \
        docker login --username AWS --password-stdin <ECR-URL>

        docker tag petclinic-app:latest $ECR_REPO:latest
        docker push $ECR_REPO:latest
        '''
      }
    }

    // -------------------------
    // STAGE 7: CONNECT TO EKS
    // -------------------------
    stage('Configure Kubeconfig') {
      steps {
        sh '''
        aws eks update-kubeconfig \
        --region $AWS_REGION \
        --name $CLUSTER_NAME
        '''
      }
    }

    // -------------------------
    // STAGE 8: DEPLOY TO EKS
    // -------------------------
    stage('Deploy') {
      steps {
        dir('app') {
          sh 'kubectl apply -f k8s/'
        }
      }
    }
  }
}
