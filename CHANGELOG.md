# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



<a name="v0.10.0"></a>
## [v0.10.0] - 2022-01-19

- feat: add EKS read-only actions to default policy ([#29](https://github.com/observeinc/terraform-aws-lambda/issues/29))


<a name="v0.9.0"></a>
## [v0.9.0] - 2022-01-14

- chore: update CHANGELOG
- fix: adjust changelog generation
- chore: update pre-commit ([#28](https://github.com/observeinc/terraform-aws-lambda/issues/28))
- feat(snapshot): add cloudfront collection ([#27](https://github.com/observeinc/terraform-aws-lambda/issues/27))
- fix: adjust collection endpoint ([#24](https://github.com/observeinc/terraform-aws-lambda/issues/24))


<a name="v0.8.0"></a>
## [v0.8.0] - 2021-11-22

- chore: update CHANGELOG
- feat: allow multiple buckets in s3_bucket_subscription ([#25](https://github.com/observeinc/terraform-aws-lambda/issues/25))
- chore: update pre-commit ([#26](https://github.com/observeinc/terraform-aws-lambda/issues/26))
- snapshot: allow extending as well as overriding actions ([#22](https://github.com/observeinc/terraform-aws-lambda/issues/22))
- pre-commit: autoupdate ([#21](https://github.com/observeinc/terraform-aws-lambda/issues/21))
- ci: add pre-commit checks ([#20](https://github.com/observeinc/terraform-aws-lambda/issues/20))


<a name="v0.7.0"></a>
## [v0.7.0] - 2021-08-23

- snapshot: extend permissions to Kinesis, SNS, SQS
- snapshot: allow configuring overrides and resources


<a name="v0.6.0"></a>
## [v0.6.0] - 2021-07-21

- cleanup: run pre-commit
- lambda: add lambda_s3_custom_rules variable ([#17](https://github.com/observeinc/terraform-aws-lambda/issues/17))
- snapshot: add description to eventbridge rule ([#15](https://github.com/observeinc/terraform-aws-lambda/issues/15))
- snapshot: add firehose to default actions ([#16](https://github.com/observeinc/terraform-aws-lambda/issues/16))


<a name="v0.5.0"></a>
## [v0.5.0] - 2021-07-12

- snapshot: adjust action prefixes ([#14](https://github.com/observeinc/terraform-aws-lambda/issues/14))
- normalize policy prefixes ([#12](https://github.com/observeinc/terraform-aws-lambda/issues/12))


<a name="v0.4.0"></a>
## [v0.4.0] - 2021-07-09

- base: update README links
- snapshot: add elasticache permissions ([#11](https://github.com/observeinc/terraform-aws-lambda/issues/11))
- pre-commit: bump versions, regenerate READMEs ([#10](https://github.com/observeinc/terraform-aws-lambda/issues/10))
- snapshot: update default actions ([#9](https://github.com/observeinc/terraform-aws-lambda/issues/9))
- Add dead_letter_queue_desitnation to the lambda function ([#8](https://github.com/observeinc/terraform-aws-lambda/issues/8))


<a name="v0.3.0"></a>
## [v0.3.0] - 2021-06-22

- snapshot: add ECS to list of default actions ([#7](https://github.com/observeinc/terraform-aws-lambda/issues/7))
- snapshot: add snapshot submodule ([#6](https://github.com/observeinc/terraform-aws-lambda/issues/6))
- s3_access_logs: add example for access logs subscription ([#5](https://github.com/observeinc/terraform-aws-lambda/issues/5))


<a name="v0.2.0"></a>
## [v0.2.0] - 2021-04-13

- cloudwatch_logs_subscription: introduce `allow_all_log_groups` ([#4](https://github.com/observeinc/terraform-aws-lambda/issues/4))
- base: add VPC config for lambda ([#3](https://github.com/observeinc/terraform-aws-lambda/issues/3))
- cloudwatch_logs_subscription: add helper submodule ([#2](https://github.com/observeinc/terraform-aws-lambda/issues/2))
- docs: cleanup, re-run pre-commit
- update pre-commit
- base: add variables


<a name="v0.1.0"></a>
## v0.1.0 - 2020-12-17

- add CHANGELOG
- s3_bucket_subscription: constrain policy to respect filter
- examples/s3_bucket: parameterize filter_prefix, filter_suffix
- s3_bucket_subscription: update README
- First commit


[Unreleased]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.10.0...HEAD
[v0.10.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.9.0...v0.10.0
[v0.9.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.8.0...v0.9.0
[v0.8.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.7.0...v0.8.0
[v0.7.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.6.0...v0.7.0
[v0.6.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.5.0...v0.6.0
[v0.5.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.2.0...v0.3.0
[v0.2.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.1.0...v0.2.0
