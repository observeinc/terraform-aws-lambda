# [4.0.0](https://github.com/observeinc/terraform-aws-lambda/compare/v3.8.0...v4.0.0) (2026-07-14)


* feat!: fix deprecated AWS provider attrs and modernize to provider >= 6.0 ([9a3f053](https://github.com/observeinc/terraform-aws-lambda/commit/9a3f05311cc0a48e557c653ec63fff8d4344952e))


### BREAKING CHANGES

* Minimum AWS provider version is now >= 6.0. Users on v5.x or below must upgrade before using this module version. s3-bucket module upgraded to ~> 4.0; run `terraform init -upgrade` after updating.



