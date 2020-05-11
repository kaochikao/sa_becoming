
### ifExists 
不太清楚 "StringEqualsIfExists"的意義，我有一個policy如下


{
    "Sid": "VisualEditor2",
    "Effect": "Allow",
    "Action": "sagemaker:CreateNotebookInstance",
    "Resource": "*",
    "Condition": {
        "StringEqualsIfExists": {
            "sagemaker:DirectInternetAccess": "Disabled"
        }
    }
}

Condition不met, error message不會寫是因為condiditon, 只會說not authorized to perform sagemaker:CreateNotebookInstance.

用CLI, 沒放"DirectInternetAccess", 原本預期會過，但不行

aws sagemaker create-notebook-instance \
--notebook-instance-name xxxxxxxx \
--instance-type ml.t2.medium \
--role-arn arn:aws:iam::xxxxxxxx:role/service-role/AWSGlueServiceSageMakerNotebookRole-xxxxxxxx \
--region eu-west-1 \
--profile test \
--subnet-id subnet-xxxxxxxx \
--security-group-ids "sg-xxxxxxxx" 

一定要明確寫
--direct-internet-access Disabled


Doc:
https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html#Conditions_IfExists



### Condition with multiple values
以下兩個都是可行的

Policy 1
-----------------------------------------------------------------
"Condition": {
    "ForAnyValue:StringEquals": {
        "sagemaker:VpcSecurityGroupIds": ["<security_group_id>"],
        "sagemaker:VpcSubnets": ["<subnet_id>"]
    }
}

Policy 2 (無bracket也可以)
-----------------------------------------------------------------
"Condition": {
    "ForAnyValue:StringEquals": {
        "sagemaker:VpcSecurityGroupIds": "<security_group_id>",
        "sagemaker:VpcSubnets": "<subnet_id>"
    }
}
-----------------------------------------------------------------