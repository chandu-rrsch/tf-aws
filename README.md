# tf-aws

To setup `aws-s3` as remote backend for terraform project, 
1. checkout to the directory `.s3-remote-setup`
    > cd .s3-remote-setup
2. make necessary changes and initialize terraform
    > terraform init
3. plan terraform
    > terraform plan
4. run terraform
    > terraform apply 


Route 53 --> Load balancer --> vpc --> instance-1
                                    \
                                      -> instance-2


                        