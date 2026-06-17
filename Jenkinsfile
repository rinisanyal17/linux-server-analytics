pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out system analytics repository from GitHub...'
            }
        }
        
        stage('Execute Telemetry Script') {
            steps {
                echo 'Running live performance metrics analytics framework...'
                sh 'chmod +x server_stats.sh'
                sh './server_stats.sh'
            }
        }
    }
}
