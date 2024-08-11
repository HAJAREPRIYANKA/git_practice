app_name=$1

env=$2

# profile=$3

is_ecs_service=$3

image_tag=$4

echo $1 $2 $3 $4

status="SUCCESS"

message="Deploy Started"


/bin/aws sts get-caller-identity 

/bin/aws cloudformation describe-stacks --stack-name $application-$env --region ap-southeast-2 --output text 2> /dev/null 1> /dev/null
STATUS_CODE=`echo $?`
echo -e "Status code is - $STATUS_CODE"
if [ "${STATUS_CODE}" -eq 0 ]
then
    if [ "${is_ecs_service}" == "true" ]
    then
        echo -e "Updating ECS stack $application-$env"
        # /bin/aws cloudformation deploy --stack-name $application-$env --template-file file://$app_name/cfn.yaml --capabilities CAPABILITY_NAMED_IAM --region ap-southeast-2 --tags file://tags.json 
        message=$(/bin/aws cloudformation update-stack --stack-name $application-$env --template-body file://$app_name/cfn.yaml --parameters file://$app_name/$env.json  --region ap-southeast-2 --capabilities  CAPABILITY_NAMED_IAM --tags file://tags.json)
        # /bin/aws cloudformation wait stack-create-complete --stack-name "${$application-$env}"
    else
        echo -e "Updating stack $application-$env"
        /bin/aws cloudformation update-stack --stack-name $application-$env --template-body file://$app_name/cfn.yaml --parameters file://$app_name/$env.json  --region ap-southeast-2 --capabilities  CAPABILITY_NAMED_IAM --tags file://tags.json 
    fi
else
    if [ "${is_ecs_service}" == "true" ]
    then
        echo -e "Creating stack $application-$env"
        /bin/aws cloudformation create-stack --stack-name $application-$env --template-body file://$app_name/cfn.yaml --parameters file://$app_name/$env.json --region ap-southeast-2  --capabilities  CAPABILITY_NAMED_IAM --tags file://tags.json 
    else
        echo -e "Creating stack $application-$env"
        /bin/aws cloudformation create-stack --stack-name $application-$env --template-body file://$app_name/cfn.yaml --parameters file://$app_name/$env.json --region ap-southeast-2  --capabilities  CAPABILITY_NAMED_IAM --tags file://tags.json 
    fi
fi

echo ${message}
