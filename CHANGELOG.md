# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



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


[Unreleased]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.5.0...HEAD
[v0.5.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.2.0...v0.3.0
[v0.2.0]: https://github.com/observeinc/terraform-aws-lambda/compare/v0.1.0...v0.2.0
