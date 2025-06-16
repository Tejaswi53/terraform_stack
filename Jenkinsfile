pipeline {
    agent any

    parameters { 
        string(name: 'Customer', defaultValue: 'kasier', description: 'Enter the customer name')
        choice(name: 'ACTIONS', choices: ['plan', 'apply', 'destroy'], description: 'Select one choice to perform terraform action')
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
                    sudo terraform fmt -check
                """
            }
        }

        stage('Terraform Init') {
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    sudo terraform init -input=false
                """
            }
        }

        stage('Terraform Validate') {
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    sudo terraform validate
                """                
            }
        }

        stage('Create or Select Workspace') {
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    if terraform workspace list | grep -q "${params.ENV}"; then
                        sudo terraform workspace select "${params.ENV}"
                    else
                        sudo terraform workspace new "${params.ENV}"
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
                    sudo terraform plan -input=false -out=tfplan -var-file="environments/${params.ENV}.tfvars"
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
                    sudo terraform show -no-color tfplan
                """
            }
        }

        stage('Manual Approval - Apply') {
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
                    sudo terraform apply -input=false tfplan
                """
            }               
        }

        stage('Manual Approval - Destroy') {
            when {
                expression { env.ACTION == 'destroy' }
            }
            steps {
                input message: "Are you sure you want to 'terraform destroy' for ${params.Customer} in ${params.ENV}?"
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { env.ACTION == 'destroy' }
            }
            steps {
                sh """
                    cd ${env.WORKSPACE}/stacks/${params.Customer}
                    sudo terraform destroy -auto-approve -var-file="environments/${params.ENV}.tfvars"
                """
            }
        }
    }
}
