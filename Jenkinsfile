pipeline {
    agent any
    
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
