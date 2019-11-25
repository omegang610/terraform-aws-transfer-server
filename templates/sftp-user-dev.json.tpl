{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "transferBucketAllow",
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
         "${transfer_bucket_arn}",
         "${transfer_bucket_arn}/*"
      ]
    }
  ]
}
