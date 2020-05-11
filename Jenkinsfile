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
                 cd /var/www/html
                 sudo killall -9 node
                 sudo npm install
                 sudo pm2 retart all
                 '''
            }
        }
    }
}