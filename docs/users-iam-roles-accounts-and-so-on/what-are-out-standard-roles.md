# What are our standard roles?

Within each account, we create a standard set of roles.

Each role name is made up of two parts: the name of the account, and the role suffix.
For example, `workflow-developer` has the account name `workflow` and the role suffix `developer`.

This is a list of our standard roles:

<table id="roles">
  <tr>
    <th>role suffix</th>
    <th>example role</th>
    <th>what it allows</th>
  </tr>
  <tr>
    <td>admin</td>
    <td>workflow-admin</td>
    <td>
      Complete access to the account.
      This is a superuser role that can do anything.
    </td>
  </tr>
  <tr>
    <td>developer</td>
    <td>platform-developer</td>
    <td>
      Complete access, bar a handful of destructive actions (e.g. deleting S3 buckets).
      This also doesn&rsquo;t allow configuring IAM users.
    </td>
  </tr>
  <tr>
    <td>read_only</td>
    <td>digitisation-read_only</td>
    <td>
      Provides read-only access to most of the account.
      This doesn't include access to secrets in Secrets Manager.
    </td>
  </tr>
  <tr>
    <td>ci</td>
    <td>identity-ci</td>
    <td>
      Provides the permissions that CI needs to do things in this account (e.g. publishing Docker images to ECR).
      Usually used by CI instances only.
    </td>
  </tr>
</table>
