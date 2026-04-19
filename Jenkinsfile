pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                echo "========================================"
                echo "STAGE: CLONE"
                echo "========================================"
                echo "Cloning repository..."
                echo "Branch: ${env.GIT_BRANCH ?: 'master'}"
                echo "Commit: ${env.GIT_COMMIT ?: 'N/A'}"
            }
        }

        stage('Build') {
            steps {
                echo "========================================"
                echo "STAGE: BUILD"
                echo "========================================"
                echo "Building the application..."
                sh 'ls -la'
                echo "Build completed successfully!"
            }
        }

        stage('Test') {
            steps {
                echo "========================================"
                echo "STAGE: TEST"
                echo "========================================"
                echo "Running tests..."
                sh '''
                    if [ -f index.html ]; then
                        echo "✓ index.html exists - PASSED"
                    else
                        echo "✗ index.html not found - FAILED"
                        exit 1
                    fi
                '''
                echo "All tests passed!"
            }
        }

        stage('Deploy') {
            steps {
                echo "========================================"
                echo "STAGE: DEPLOY"
                echo "========================================"
                echo "Deploying to nginx..."
                sh '''
                    sudo cp index.html /var/www/html/
                    sudo chown www-data:www-data /var/www/html/index.html
                '''
                echo "Deployment successful!"
                echo "Site is live at: http://104.197.51.120/"
            }
        }
    }

    post {
        success {
            echo "========================================"
            echo "PIPELINE SUCCEEDED!"
            echo "Your site is now live."
            echo "========================================"
        }
        failure {
            echo "========================================"
            echo "PIPELINE FAILED!"
            echo "Check the logs above for errors."
            echo "========================================"
        }
    }
}
