{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "transferBucketAllow1",
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "${transfer_bucket_arn}/read_write/*"
    },
    {
      "Sid": "transferBucketAllow2",
      "Effect": "Allow",
      "Action": "s3:List*",
      "Resource": "${transfer_bucket_arn}"
    },
    {
      "Sid": "transferBucketDeny1",
      "Effect": "Deny",
      "Action": "s3:Delete*",
      "Resource": "${transfer_bucket_arn}/read_write/*"
    },
    {
      "Sid": "transferBucketAllow3",
      "Effect": "Allow",
      "Action": [
        "s3:List*",
        "s3:Get*"
      ],
      "Resource": "${transfer_bucket_arn}/readonly/*"
    }
  ]
}
