pipeline {
    agent any

    // environment {
    //     GITHUB_TOKEN = credentials('your-github-token-id')
    // }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Change to the desired branch
                    checkout([$class: 'GitSCM', branches: [[name: '*/<branch_name>']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/your_username/your_repo.git']]])

                    // Set GitHub credentials
                    withCredentials([string(credentialsId: 'your-github-token-id', variable: 'GITHUB_TOKEN')]) {
                        // Set GitHub repo URL
                        def repoUrl = 'https://github.com/anmolkalra17/TipCalcCombine.git'
                        sh "git remote set-url origin $repoUrl"                        
                    }
                }
            }
        }

        stage('Clean') {
            steps {
                script {
                    // Source the environment or any setup script
                    sh "source ~/.bash_profile" // Update with your setup script if needed

                    // Invoke fastlane to clean
                    sh "fastlane clean" // Update with your fastlane command
                }
            }
        }

        stage('Code Signing') {
            steps {
                script {
                    // Uncomment the following lines if code signing is needed
                    sh "fastlane ios adhoc" // Update with your code signing command
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build using gym command in fastlane
                    sh "fastlane ios build" // Update with your build command
                }
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed!'
            // Add any necessary post-failure steps or notifications here
        }
    }
}
