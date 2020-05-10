pipeline{
    agent{
        label'master'
    }
    stages{
        stage('git pull'){
            steps{
                sh '''
                 cd /var/www/node-js-getting-started/
                 sudo git pull
                 '''
            }
        }
        stage('build'){
            steps{
                 sh '''
                 cd  /var/www/node-js-getting-started/
                 sudo npm install
                 '''
            }
        }
        stage('deploy'){
            steps{
                 sh '''
                 cd /var/www/node-js-getting-started/
                 sudo npm start
                 '''
            }
        }
    }
}