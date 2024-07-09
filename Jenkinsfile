@Library('my-shared-library@main') _

pipeline{

    agent any

    parameters{
        choice(name: 'action', choices: 'create\ndelete', description: 'Choose create/Destroy')
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
        stage('checkstyle'){
        when { expression {  params.action == 'create' } }
            steps{
                script{
                    checkstyle()
                }
            }
        }
        stage('unit test maven'){
            when { expression {  params.action == 'create' } }
            steps{
                script{
                    mvnTest()
                }
            }
        }
        stage('integration test maven'){
            when { expression {  params.action == 'create' } }
            steps{
                script{
                    mvnIntegrationTest()
                }
            }
        }

        stage('Static code analysis: Sonarqube'){
        when { expression {  params.action == 'create' } }
            steps{
                script{
                    def SonarQubecredentialsId = 'sonar-token'
                    statiCodeAnalysis(SonarQubecredentialsId)
                }
            }
        }

        stage('Quality Gate Status Check : Sonarqube'){
            when { expression {  params.action == 'create' } }
            steps{
                script{
                    def SonarQubecredentialsId = 'sonar-token'
                    QualityGateStatus(SonarQubecredentialsId)
                }
            }
        }



    }
}
