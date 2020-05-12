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
                 sudo cp -r * /var/www/html/
                 cd /var/www/html/
                 '''
            }
        }
        stage('deploy'){
            steps{
                 sh '''
                 sudo pm2 restart all

                 '''
            }
        }
    }
}