pipeline{
    agent{
        label'master'
    }
    stages{
        stage('git pull'){
            steps{
                sh '''
                 cd /var/www/node-test/
                 git pull
                 '''
            }
        }
        stage('build'){
            steps{
                 sh '''
                 cd  /var/www/node-test/
                 sudo npm install
                 '''
            }
        }
        stage('deploy'){
            steps{
                 sh '''
                 cd /var/www/node-test/
                 sudo npm start
                 '''
            }
        }
    }
}