
aws iam create-instance-profile --instance-profile-name case_test_user

aws iam add-role-to-instance-profile \
--instance-profile-name case_test_user \
--role-name case_test_user_role

aws iam list-instance-profiles