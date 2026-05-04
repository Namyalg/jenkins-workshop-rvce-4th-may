pipeline {
    agent any // Run on any available Jenkins agent

    environment {
        // Jenkins automatically provides env.GIT_BRANCH (e.g., "origin/feature/alice")
        // Strip "origin/" prefix to get clean branch name for deployment paths
        BRANCH_NAME = "${env.GIT_BRANCH?.replaceAll('origin/', '') ?: 'feature/manoj'}"
    }

    stages {
        stage('Clone') {
            // Note: Jenkins Multibranch Pipeline automatically clones the repo before running this pipeline
            // This stage just displays information about what was cloned
            steps {
                echo "========================================"
                echo "STAGE: CLONE"
                echo "========================================"
                echo "Cloning repository..."
                echo "Branch: ${BRANCH_NAME}"
                echo "Commit: ${env.GIT_COMMIT ?: 'N/A'}" // Jenkins provides GIT_COMMIT automatically
            }
        }

        stage('Build') {
            steps {
                echo "========================================"
                echo "STAGE: BUILD"
                echo "========================================"
                echo "Building the application..."
                sh 'ls -la' // List files to verify workspace contents
                echo "Build completed successfully!"
            }
        }

        stage('Test') {
            when {
                not { branch 'master' } // Skip tests on master branch
            }
            steps {
                echo "========================================"
                echo "STAGE: TEST"
                echo "========================================"
                echo "Running tests..."
                sh 'chmod +x tests.sh && ./tests.sh' // Run validation tests - pipeline fails if tests fail
            }
        }

        stage('Deploy') {
            steps {
                echo "========================================"
                echo "STAGE: DEPLOY"
                echo "========================================"
                echo "Deploying branch: ${BRANCH_NAME}"
                script {
                    // Generate deployment timestamp in IST timezone
                    def timestamp = sh(script: 'TZ="Asia/Kolkata" date "+%Y-%m-%d %H:%M:%S IST"', returnStdout: true).trim()
                    echo "Adding current timestamp: ${timestamp}"

                    sh """
                        # Create branch-specific directory for deployment
                        sudo mkdir -p /var/www/html/${BRANCH_NAME}

                        # Replace timestamp placeholder and deploy to nginx directory
                        sed 's/TIMESTAMP_PLACEHOLDER/${timestamp}/' index.html | sudo tee /var/www/html/${BRANCH_NAME}/index.html > /dev/null

                        # Set proper ownership for nginx
                        sudo chown -R www-data:www-data /var/www/html/${BRANCH_NAME}
                    """
                }
                echo "Deployment successful!"
                echo "========================================"
                echo "Site is live at: http://104.197.51.120/${BRANCH_NAME}/"
                echo "========================================"
            }
        }
    }

    post {
        success { // Runs only if all stages succeeded
            echo "========================================"
            echo "PIPELINE SUCCEEDED!"
            echo "Your site is now live at: http://104.197.51.120/${BRANCH_NAME}/"
            echo "========================================"
        }
        failure { // Runs if any stage failed (e.g., tests failed)
            echo "========================================"
            echo "PIPELINE FAILED!"
            echo "Check the logs above for errors."
            echo "========================================"
        }
    }
}
