pipeline {
    agent any

    parameters { 
        string(name: 'Customer', defaultValue: 'kasier', description: 'Enter the customer name')
        choice(name: 'ACTIONS', choices: ['plan', 'apply'], description: 'Select one choice to perform terraform action')
        choice(name: 'ENV', choices: ['dev', 'stage', 'prod'], description: 'Select the environment')
    }

    environment {
        ACTION = "${params.ACTIONS}"
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Tejaswi53/terraform_stack.git'
            }
        }

        stage('Terraform Format') {
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    terraform fmt -check
                """
            }
        }

        stage('Terraform Init') {
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    terraform init -input=false
                """
            }
        }

        stage('Terraform Validate') {
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    terraform validate
                """                
            }
        }

        stage('Create or Select Workspace') {
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    if terraform workspace list | grep -q "${params.ENV}"; then
                        terraform workspace select "${params.ENV}"
                    else
                        terraform workspace new "${params.ENV}"
                    fi
                """
            }
        }

        stage('Terraform Plan') {
            when {
                expression { env.ACTION == 'plan' || env.ACTION == 'apply' }
            }
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    terraform plan -input=false -out=tfplan -var-file="environments/${params.ENV}.tfvars"
                """
            }
        }

        stage('Show Terraform Plan') {
            when {
                expression { env.ACTION == 'plan' || env.ACTION == 'apply' }
            }
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    terraform show -no-color tfplan
                """
            }
        }

        stage('Manual Approval') {
            when {
                expression { env.ACTION == 'apply' }
            }
            steps {
                input message: "Do you want to proceed with 'terraform apply' for ${params.Customer} in ${params.ENV}?"
            }
        }

        stage('Terraform Apply') {
            when {
                expression { env.ACTION == 'apply' }
            }
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    terraform apply -input=false tfplan
                """
            }               
        }
    }
}
