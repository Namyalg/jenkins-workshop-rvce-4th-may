pipeline {
    agent any

    environment {
        BRANCH_NAME = "${env.GIT_BRANCH?.replaceAll('origin/', '') ?: 'master'}"
    }

    stages {
        stage('Clone') {
            steps {
                echo "========================================"
                echo "STAGE: CLONE"
                echo "========================================"
                echo "Cloning repository..."
                echo "Branch: ${BRANCH_NAME}"
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
            when {
                not { branch 'master' }
            }
            steps {
                echo "========================================"
                echo "STAGE: TEST"
                echo "========================================"
                echo "Running tests..."
                sh 'chmod +x tests.sh && ./tests.sh'
            }
        }

        stage('Deploy') {
            steps {
                echo "========================================"
                echo "STAGE: DEPLOY"
                echo "========================================"
                echo "Deploying branch: ${BRANCH_NAME}"
                sh """
                    # Create directory for this branch
                    sudo mkdir -p /var/www/html/${BRANCH_NAME}

                    # Generate timestamp
                    TIMESTAMP=\$(date '+%Y-%m-%d %H:%M:%S')

                    # Create index.html with timestamp injected
                    sed "s/TIMESTAMP_PLACEHOLDER/\$TIMESTAMP/" index.html > index_deploy.html

                    # Copy files to branch directory
                    sudo cp index_deploy.html /var/www/html/${BRANCH_NAME}/index.html

                    # Set permissions
                    sudo chown -R www-data:www-data /var/www/html/${BRANCH_NAME}
                """
                echo "Deployment successful!"
                echo "========================================"
                echo "Site is live at: http://104.197.51.120/${BRANCH_NAME}/"
                echo "========================================"
            }
        }
    }

    post {
        success {
            echo "========================================"
            echo "PIPELINE SUCCEEDED!"
            echo "Your site is now live at: http://104.197.51.120/${BRANCH_NAME}/"
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
