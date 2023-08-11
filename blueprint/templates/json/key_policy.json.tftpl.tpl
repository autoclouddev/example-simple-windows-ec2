{
    "Sid": "Enable IAM policies",
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${account_num}:root"
     },
    "Action": "kms:*",
    "Resource": "*"
  }