# [4.0.0](https://github.com/observeinc/terraform-aws-lambda/compare/v3.8.0...v4.0.0) (Unreleased)


### ⚠ BREAKING CHANGES

* **providers**: Minimum AWS provider version raised from `>= 2.68` to `>= 6.0` across all modules and examples. Users on AWS provider v5.x or below must upgrade before using this module version. The v6.0 breaking changes do not affect any resources managed by this module — see the [AWS provider v6.0 changelog](https://github.com/hashicorp/terraform-provider-aws/blob/main/CHANGELOG.md) for the full list.

* **modules/s3_bucket**: `terraform-aws-modules/s3-bucket` dependency upgraded from `~> 3.7.0` to `~> 5.0`. After updating, run `terraform init -upgrade` to fetch the new module version. The input variable interface is unchanged for all inputs used by this module (`acl`, `logging`, `lifecycle_rule`, `server_side_encryption_configuration`, `attach_policy`, `attach_elb_log_delivery_policy`, `attach_lb_log_delivery_policy`). The v5 module also aligns with the `aws >= 6.0` provider requirement and raises the minimum Terraform version for this module to `>= 1.10`.


### Bug Fixes

* Replace deprecated `data.aws_region.current.id` attribute with `.region` in `main.tf` — in AWS provider v6.0, `.id` and `.name` are both deprecated in favor of `.region` ([OBSSD-4274](https://observe.atlassian.net/browse/OBSSD-4274))


### Improvements

* **main.tf**: Convert all IAM policy inline documents from heredoc (`<<EOF`) to `jsonencode()`. Functionally identical — eliminates fragile mixed heredoc+interpolation patterns and improves readability.
* **modules/s3_bucket_subscription**: Convert IAM policy heredoc to `jsonencode()`.
* **examples/s3_access_logs**: Replace deprecated inline `logging {}` block on `aws_s3_bucket` with standalone `aws_s3_bucket_logging` resource (deprecated in AWS provider v4).
* **examples/vpc_config**: Replace deprecated inline `egress {}` block on `aws_security_group` with standalone `aws_vpc_security_group_egress_rule` resource (deprecated in AWS provider v5).
* **ci**: Update terraform-docs in CI workflow from v0.15.0 to v0.21.0. Pin tflint to v0.63.1 with a direct download URL (replaces fragile `releases/latest` regex).
* **examples/cloudtrail**: Bump `cloudposse/cloudtrail/aws` from `0.15.0` to `0.24.0` and `cloudposse/cloudtrail-s3-bucket/aws` from `0.15.0` to `0.32.0`. Previous versions had stale git references in the Terraform registry that prevented CI validation.
* **examples/s3_bucket, examples/cloudtrail**: Raise `required_version` to `>= 1.10`. Terraform versions below 1.10 cannot resolve SHA-based `ref=` git references used by newer Terraform registry module entries, causing `terraform init` to fail in CI.


# [3.8.0](https://github.com/observeinc/terraform-aws-lambda/compare/v3.7.0...v3.8.0) (2026-02-24)


### Features

* Update Lambda Runtime to provided.al2023 ([3698b74](https://github.com/observeinc/terraform-aws-lambda/commit/3698b74e42bb955d90fe4688609243dac70a350e))



# [3.7.0](https://github.com/observeinc/terraform-aws-lambda/compare/v3.6.0...v3.7.0) (2025-05-07)


### Bug Fixes

* Fix S3 Bucket Notification Configuration Validation Error OBSSD-612 ([a708fc6](https://github.com/observeinc/terraform-aws-lambda/commit/a708fc6f17fadf1330c048d4165a1a3385de8a9b))


### Features

* Update for apigatewayv2 ([a191b9c](https://github.com/observeinc/terraform-aws-lambda/commit/a191b9c8678d9f2c3aecfce14e6d0a5d8e7371fb))



