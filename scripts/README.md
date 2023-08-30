These are scripts to do stuff in AWS.

## The individual scripts

<dl>
  <dt>
    <code>create_account_role_config.py</code>
  </dt>
  <dd>
    This creates the config files for the AWS CLI and the Chrome "Fast Role Switcher" extension.
  </dd>

  <dt>
    <code>describe_iam_access_key.py [ACCESS_KEY_ID]</code>
  </dt>
  <dd>
    This is a tool for getting information about an IAM Access Key – for example, which account it's in, which user it's associated with, what permissions it has.
    This can be useful when you have an Access Key ID but no other information to assist in your debugging.
  </dd>
</dl>

## Running a script across every AWS account

Sometimes it may be useful to run the same script in every one of our AWS accounts; you can do this with the `get_all_aws_accounts()` helper function.

For example, if you want to list all the Key Pairs in EC2 in every account:

```python
#!/usr/bin/env python3

from config import get_all_aws_accounts


if __name__ == "__main__":
    for account_id, account_name, sess in get_all_aws_accounts():
        ec2 = sess.client("ec2")
        resp = ec2.describe_key_pairs()

        if not resp["KeyPairs"]:
            continue

        print(f'\n== {account_name} ({account_id}) ==')

        for kp in resp["KeyPairs"]:
            print(kp["KeyName"])
```
