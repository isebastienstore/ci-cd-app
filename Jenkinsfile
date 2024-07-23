@Library('my-shared-library@main') _

pipeline{

    agent any

    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
        string(name: 'ImageName', description: 'name of the docker build', defaultValue: 'ci-cd-app')
        string(name: 'ImageTag', description: 'tag of the docker build', defaultValue: 'v1')
        string(name: 'DockerHubUser', description: 'name of the application', defaultValue: 'isebastienstore')
    }

    stages{
        stage('git Checkout'){
        when { expression {  params.action == 'create' } }
            steps{
                script{
                    gitCheckout()
                }
            }
        }
        stage('clean'){
        when { expression {  params.action == 'create' } }
            steps{
                script{
                    clean()
                }
            }
        }


        stage('Maven Build : maven'){
            when { expression {  params.action == 'create' } }
            steps{
                script{
                    mvnBuild()
                }
            }
        }

        stage('Docker image build'){
            when { expression { params.action == 'create' } }
            steps{
                script{
                    dockerBuild("${params.ImageName}", "${params.ImageTag}", "${params.DockerHubUser}")
                }
            }
        }

        stage('Docker image scan: trivy'){
            when{ expression { params.action == 'create'} }
            steps{
                script{
                    dockerImageScan("${params.ImageName}", "${params.ImageTag}", "${params.DockerHubUser}")
                }
            }
        }

        stage('Docker image push: DockerHub'){
            when{ expression { params.action == 'create'} }
            steps{
                script{
                    dockerImagePush("${params.ImageName}", "${params.ImageTag}", "${params.DockerHubUser}")
                }
            }
        }

        stage('Docker image cleanup: DockerHub'){
            when{ expression { params.action == 'create'} }
            steps{
                script{
                    dockerImageCleanup("${params.ImageName}", "${params.ImageTag}", "${params.DockerHubUser}")
                }
            }
        }
    }
}
