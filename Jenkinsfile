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
                 sudo apt install nodejs -y
                 sudo apt install npm -y
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