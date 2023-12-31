# Workflow support role

locals {
  account_ids = {
    platform = "760097843905"
    workflow = "299497370133"
  }

  account_principals = { for key, value in local.account_ids : key => "arn:aws:iam::${value}:root" }
}

module "workflow_support_role" {
  source = "../../modules/assumable_role"

  name = "workflow-support"

  principals = [
    local.account_principals["platform"]
  ]
}

resource "aws_iam_role_policy" "workflow_support" {
  role   = module.workflow_support_role.name
  policy = data.aws_iam_policy_document.workflow_support.json
}

data "aws_iam_policy_document" "workflow_support" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:Get*",
      "s3:Put*",
      "s3:DeleteObject",
      "s3:RestoreObject",
      "s3:CopyObject*",
      "s3:Head*",
    ]

    resources = [
      # Buckets in the digitisation account
      "arn:aws:s3:::wellcomecollection-archivematica-transfer-source",
      "arn:aws:s3:::wellcomecollection-archivematica-transfer-source/*",
      "arn:aws:s3:::wellcomecollection-archivematica-staging-transfer-source",
      "arn:aws:s3:::wellcomecollection-archivematica-staging-transfer-source/*",
      "arn:aws:s3:::wellcomecollection-client-transfer-pre2020",
      "arn:aws:s3:::wellcomecollection-client-transfer-pre2020/*",
      "arn:aws:s3:::wellcomecollection-digitisation-av",
      "arn:aws:s3:::wellcomecollection-digitisation-av/*",
      "arn:aws:s3:::wellcomecollection-delivery-service",
      "arn:aws:s3:::wellcomecollection-delivery-service/*",

      # Buckets in the workflow account
      "arn:aws:s3:::wellcomecollection-workflow-upload",
      "arn:aws:s3:::wellcomecollection-workflow-upload/*",
      "arn:aws:s3:::wellcomecollection-workflow-stage-upload",
      "arn:aws:s3:::wellcomecollection-workflow-stage-upload/*",

      # Buckets in the platform account
      "arn:aws:s3:::wellcomecollection-client-transfer",
      "arn:aws:s3:::wellcomecollection-client-transfer/*",
      "arn:aws:s3:::wellcomecollection-editorial-photography",
      "arn:aws:s3:::wellcomecollection-editorial-photography/*",
    ]
  }

  # Allow workflow-support users to access (but not modify) the MIRO
  # and Preservica archives.
  statement {
    actions = [
      "s3:List*"
    ]

    resources = [
      "arn:aws:s3:::wellcomecollection-assets-workingstorage",
      "arn:aws:s3:::wellcomecollection-assets-workingstorage/*",
    ]
  }

  statement {
    actions = [
      "s3:Get*"
    ]

    resources = [
      "arn:aws:s3:::wellcomecollection-assets-workingstorage/preservica/*",
    ]
  }

  # Allow workflow-support users to access the AV data in the assets bucket.
  statement {
    actions = [
      "s3:List*",
      "s3:Get*",
    ]

    resources = [
      "arn:aws:s3:::wellcomecollection-assets-workingstorage",
      "arn:aws:s3:::wellcomecollection-assets-workingstorage/av/*",
    ]
  }

  # Allow workflow-support users to see the name (but not contents) of
  # every bucket in the workflow account.
  #
  # This allows them to see the list of buckets in the "Actions > Move" menu,
  # which is useful for moving objects in the workflow-upload bucket,
  # e.g. to move a package from "failed" to the live folder.
  statement {
    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }

  # Allow workflow-support users to browse the contents of the storage service,
  # and download files in the digitised/ prefix.
  #
  # This is used to copy videos into the Goobi storage bucket for reingest.
  # See https://wellcome.slack.com/archives/CN56BRQ5B/p1594804248033200
  statement {
    actions = [
      "s3:List*",
    ]

    resources = [
      "arn:aws:s3:::wellcomecollection-storage",
      "arn:aws:s3:::wellcomecollection-storage/*",
      "arn:aws:s3:::wellcomecollection-storage-staging",
      "arn:aws:s3:::wellcomecollection-storage-staging/*",
    ]
  }

  statement {
    actions = [
      "s3:Get*",
    ]

    resources = [
      "arn:aws:s3:::wellcomecollection-storage/digitised/*",
      "arn:aws:s3:::wellcomecollection-storage/miro/*",
      "arn:aws:s3:::wellcomecollection-storage-staging/digitised/*",
    ]
  }

  # Allow workflow-support users to use CloudShell, so they can use
  # the AWS CLI in the browser rather than installing locally.
  statement {
    actions = [
      "cloudshell:*",
    ]

    resources = ["*"]
  }
}
