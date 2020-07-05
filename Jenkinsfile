pipeline{
    agent any
    environment {
        AWS_ACCESS_KEY_ID=credentials('accesskey_id')
        AWS_SECRET_ACCESS_KEY=credentials('secretkey_id')
        AWS_DEFAULT_REGION='us-east-2'
        REPOSITORY_URI='792026813527.dkr.ecr.us-east-2.amazonaws.com/herok'
        SERVICE_NAME="herok"
        TASK_FAMILY="herok"
    }
    stages{
        stage('ecr configure'){
            steps{
                sh 'aws --version'
                sh '''
                aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 792026813527.dkr.ecr.us-east-2.amazonaws.com
                 '''
            }
        }
        stage('build'){
            steps{
                 sh '''
                 docker build -t $REPOSITORY_URI:latest . && \
                 docker tag $REPOSITORY_URI:latest $REPOSITORY_URI:$GIT_COMMIT 
                 '''
            }
        }
        stage('eCR PUSH'){
            steps{
                sh '''
                 docker push $REPOSITORY_URI:latest && \
                 docker push $REPOSITORY_URI:$GIT_COMMIT 
                 '''
            }
        }
        stage('pre-deploy'){
            steps{
                 sh '''
                 sed -e "s;%BUILD_NUMBER%;${GIT_COMMIT};g" taskdefination.json > herok-${GIT_COMMIT}.json
                 cat herok-${GIT_COMMIT}.json
                 '''
                 sh 'aws ecs register-task-definition --family herok --cli-input-json file://$PWD/herok-${GIT_COMMIT}.json'
                 sh '''
                 TASK_REVISION=`aws ecs describe-task-definition --task-definition herok | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/"$//'`
                 DESIRED_COUNT=`aws ecs describe-services --services ${SERVICE_NAME} | egrep "desiredCount" | tr "/" " " | awk '{print $2}' | sed 's/,$//'`
                 if [ ${DESIRED_COUNT} = "0" ]; then
                 DESIRED_COUNT="1"
                 fi  
                 aws ecs update-service --cluster herok --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count 1
                 sleep 60
                '''
            }
        }
    }
}
