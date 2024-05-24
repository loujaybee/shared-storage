# shared-folder-sample-lib

### Setup OIDC and S3 on AWS

1. Create an Identity Provider in AWS
 - Search for "Identity Provider" in the AWS Management Console
 - Select "Add Provider"
 - Set https://services.<company>.gitpod.cloud/idp as the provider url
 - Select OpenID Connect as Provider Type
 - Set sts.amazonaws.com as the audience type
 - Create provider

2. Create an S3 bucket named "shared-state-test". You can change the name if you change it in the .gitpod.ymls as well.

3. Create policy for accessing the bucket
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::shared-state-test"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::shared-state-test/*"
        }
    ]
}
```

4. Create Web Identity role
- Select the identity provider that you just created
- Set the audience
- In the next step add the policy to the role