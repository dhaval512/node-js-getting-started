pipeline{
    agent{
        label'master'
    }
    environment {
        AWS_ACCESS_KEY_ID=credentials('accesskey_id')
        AWS_SECRET_ACCESS_KEY=credentials('secretkey_id')
        AWS_DEFAULT_REGION='us-east-1'
        REPOSITORY_URI='792026813527.dkr.ecr.us-east-1.amazonaws.com/heroku'
        IMAGE_TAG="${heroku:latest}" 
        SERVICE_NAME="heroku"
        TASK_FAMILY="heroku"
    }
    stages{
        stage('ecr configure'){
            steps{
                sh '''
                 aws ecr get-login --region $AWS_DEFAULT_REGION
                 '''
            }
        }
        stage('build'){
            steps{
                 sh '''
                 docker build -t $REPOSITORY_URI:latest . && \
                 docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$IMAGE_TAG 
                 '''
            }
        }
        stage('eCR PUSH'){
            steps{
                sh '''
                 docker push $REPOSITORY_URI:latest && \
                 docker push $REPOSITORY_URI:$IMAGE_TAG 
                 '''
            }
        }
        stage('pre-deploy'){
            steps{
                 sh '''
                 sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" taskdefination.json > heroku-${BUILD_NUMBER}.json
                 '''
                 sh 'aws ecs register-task-definition --family heroku --cli-input-json file://heroku_${BUILD_NUMBER}.json'
                 sh '''
                 TASK_REVISION=`aws ecs describe-task-definition --task-definition heroku | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/"$//'`  
                 aws ecs update-service --cluster default --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count 1
                '''
            }
        }
    }
}
