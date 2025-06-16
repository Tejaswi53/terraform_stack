pipeline {
    agent any
    
    parameters { 
        string(name: 'Customer', defaultValue: 'kasier', description: 'Enter the customer name')
        choice(name: 'ACTIONS', choices: ['plan', 'apply'], description: 'Select one choice to perform terraform action')
        choice(name: 'ENV', choices: ['dev', 'stage', 'prod'], description: 'select the environment')
        
    }

    stages {

        stage('git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Tejaswi53/terraform_stack.git'
            }
        }

        stage('terraform format') {
            steps {
                sh """
                  pwd
                  ls -l
                  echo "${env.WORKSPACE}"

                  cd ${env.WORKSPACE}/stacks/${params.Customer}
                  terraform fmt -check
                """
            }
        }

        stage('terraform init') {
            steps {
                sh """
                  cd ${env.WORKSPACE}/stacks/${params.Customer}
                  terraform init -input=false
                """
            }
        }

        stage('terraform validate') {
            
            steps {
                sh """
                  cd ${env.WORKSPACE}/stacks/${params.Customer}
                  terraform validate
                """                
            }
        }

        stage('aws login') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'riaws1', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                 // some block

                }
            }
        }

        stage('trivy scan') {
            steps {
                sh "trivy config stacks/${params.Customer} --output scanReport.json"
            }
        }

        stage('create or select workspace') {
            steps{
                sh """
                cd stacks/${params.Customer}
                if terraform workspace list | grep -q "${params.ENV}"; then
                   terraform workspace select "${params.ENV}"
                else
                   terraform workspace new "${params.ENV}"
                   terraform workspace select "${params.ENV}"
                fi
                """
            }
        }

        stage('terraform plan') {
            when {
                expression { ${params.ACTIONS} == /(plan|apply)/ }
            }
            steps {
                sh """
                  cd stacks/${params.Customer}
                  terraform plan -input=false -out=tfplan -var-file="environments/${params.ENV}.tfvars"
                """               
            }
        }

        stage('terraform apply') {
            when {
                expression { ${params.ACTIONS} == /(apply)/ }
            }
            steps {
                sh """
                  cd stacks/${params.Customer}
                  terraform apply -input=false -auto-approve tfplan -var-file="environments/${params.ENV}.tfvars"
                """
            }               
        }
    }
}
