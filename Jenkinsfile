pipeline{
    agent{
        label'master'
    }
    stages{
        stage('hello'){
            steps{
                sh '''
                 echo "hello"
                 '''
            }
        }
        stage('build'){
            steps{
                 sh '''
                 sudo cp * /var/www/html/
                 cd /var/www/html/
                 sudo npm install
                 '''
            }
        }
        stage('deploy'){
            steps{
                 sh '''
                 cd /var/www/html
                 sudo npm start
                 '''
            }
        }
    }
}