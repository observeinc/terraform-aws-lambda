# [2.0.0](https://github.com/observeinc/terraform-aws-lambda/compare/v1.1.2...v2.0.0) (2023-03-02)


### Bug Fixes

* **s3_bucket_subscription:** use `aws_arn` data source ([#50](https://github.com/observeinc/terraform-aws-lambda/issues/50)) ([129aa8b](https://github.com/observeinc/terraform-aws-lambda/commit/129aa8b867018389740456bcc04ae7fb8ce85c2a))


* feat(s3_bucket_subscription)!: convert `bucket_arns` to set (#49) ([a13b8fd](https://github.com/observeinc/terraform-aws-lambda/commit/a13b8fd75c8f1e882da0d2869a39acd06930a9e0)), closes [#49](https://github.com/observeinc/terraform-aws-lambda/issues/49)


### BREAKING CHANGES

* migrating from previous versions may result in a race
condition where terraform attempts to create a new
`aws_s3_bucket_notification` prior to destroying the previous one.
Re-running apply should successfully work around this issue.



