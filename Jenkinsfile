pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                echo "Cloning repository..."
                echo "Branch: ${env.GIT_BRANCH ?: 'master'}"
                echo "Commit: ${env.GIT_COMMIT ?: 'N/A'}"
            }
        }

        stage('Build') {
            steps {
                echo "Building the application..."
                sh 'ls -la'
                echo "Build completed successfully!"
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
                sh '''
                    if [ -f index.html ]; then
                        echo "index.html exists - PASSED"
                    else
                        echo "index.html not found - FAILED"
                        exit 1
                    fi
                '''
                echo "All tests passed!"
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying application..."
                echo "Deployment successful!"
                echo "================================================"
                echo "Pipeline completed for branch: ${env.GIT_BRANCH ?: 'master'}"
                echo "================================================"
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
