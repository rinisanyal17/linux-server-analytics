pipeline {
    agent none
    
    environment {
        // Prevents Python from buffering stdout, ensuring logs stream instantly in Jenkins
        PYTHONUNBUFFERED = '1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out system analytics repository from GitHub...'
            }
        }
        
        stage('Execute Telemetry Script') {
            agent {
                docker {
                    image 'python:3.10-alpine' // A tiny, lightweight production Linux image with Python 3 pre-installed
                    reuseNode true // Reuses the workspace from the checkout stage
                }
            }
            steps {
                echo 'Running live performance metrics analytics framework via Python...'
                // Pointing to your fresh Python execution engine instead of Bash
                sh 'python3 edge_telemetry.py'
            }
        }
       // Legacy Stage Kept for Architectural History (Commented out using valid Groovy syntax) 
      //stage('Execute Legacy Bash Telemetryt') {
       //     steps {
    //        echo 'Running live performance metrics analytics framework...'
         //       sh 'chmod +x server-stats.sh'
          //      sh './server-stats.sh'
           // }
       // }
    }
}
