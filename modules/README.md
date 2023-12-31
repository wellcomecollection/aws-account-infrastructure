<dl>
  <dt>
    <a href="https://github.com/wellcomecollection/aws-account-infrastructure/tree/main/modules/account_roles">
      <code>account_roles</code>
    </a>
  </dt>
  <dd>
    Creates our standard set of IAM roles inside an AWS account.
  </dd>

  <dt>
    <a href="https://github.com/wellcomecollection/aws-account-infrastructure/tree/main/modules/assumable_role">
      <code>assumable_role</code>
    </a>
  </dt>
  <dd>
    Creates an IAM role which can be assumed by a given list of IAM principals.
    It’s a thin wrapper around the <code>aws_iam_role</code> resource.
  </dd>

  <dt>
    <a href="https://github.com/wellcomecollection/aws-account-infrastructure/tree/main/modules/initial_role">
      <code>initial_role</code>
    </a>
  </dt>
  <dd>
    Creates the IAM roles that users assume when they first log into our AWS estate.
  </dd>

  <dt>
    <a href="https://github.com/wellcomecollection/aws-account-infrastructure/tree/main/modules/role_policies">
      <code>role_policies</code>
    </a>
  </dt>
  <dd>
    Defines the IAM role policies for our standard IAM roles.
  </dd>

  <dt>
    <a href="https://github.com/wellcomecollection/aws-account-infrastructure/tree/main/modules/vpc">
      <code>vpc</code>
    </a>
  </dt>
  <dd>
    Creates a VPC with our standard networking config.
  </dd>
</dl>
