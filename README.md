cloudfront URL: d124cq6ki5be51.cloudfront.net (right bucket?)

== S3 Bucket permissions

By default S3 won't accept cross origin requests. You need the following information (and access to the console) to reconfigure it:

CORS configuration:

```
<CORSConfiguration>
    <CORSRule>
        <AllowedOrigin>http://0.0.0.0:3000</AllowedOrigin>
        <AllowedOrigin>http://droptab.herokuapp.com</AllowedOrigin>
        <AllowedMethod>GET</AllowedMethod>
        <AllowedMethod>POST</AllowedMethod>
        <AllowedMethod>PUT</AllowedMethod>
        <MaxAgeSeconds>3000</MaxAgeSeconds>
        <AllowedHeader>*</AllowedHeader>
    </CORSRule>
</CORSConfiguration>
```

Bucket policy

```
{
  "Version": "2008-10-17",
  "Id": "ZencoderBucketPolicy",
  "Statement": [
    {
      "Sid": "Stmt1295042087538",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::395540211253:root"
      },
      "Action": [
        "s3:GetObject",
        "s3:PutObjectAcl",
        "s3:ListMultipartUploadParts",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::droptab-production/*"
    },
    {
      "Sid": "Stmt1295042087538",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::395540211253:root"
      },
      "Action": [
        "s3:ListBucketMultipartUploads",
        "s3:GetBucketLocation"
      ],
      "Resource": "arn:aws:s3:::droptab-production"
    }
  ]
}
```

== Testing locally

Since Zencoder can't ping your localhost directly, run the "zencoder fetcher":

```bash
(localhost)$ zencoder_fetcher --url=http://localhost:3000/zencoder-callback 0ab8ceb96ad599029be41f431d604cb4
ruby: warning: RUBY_FREE_MIN is obsolete. Use RUBY_GC_HEAP_FREE_SLOTS instead.
Notifications retrieved: 50
Posting to http://localhost:3000/zencoder-callback
Finished Posting
```
