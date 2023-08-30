import boto3


WELLCOME_ACCOUNT_NAMES = {
    "299497370133": "workflow",
    "404315009621": "digitisation",
    "760097843905": "platform",
    "756629837203": "catalogue",
    "964279923020": "data",
    "653428163053": "digirati",
    "130871440101": "experience",
    "770700576653": "identity",
    "269807742353": "reporting",
    "975596993436": "storage",
    "782179017633": "microsites",
    "269807742353": "reporting",
    "975596993436": "storage",
    "299497370133": "workflow",
    "782179017633": "microsites",
    "487094370410": "systems_strategy",
}


def get_aws_session(*, role_arn):
    sts_client = boto3.client("sts")
    assumed_role_object = sts_client.assume_role(
        RoleArn=role_arn, RoleSessionName="AssumeRoleSession1"
    )
    credentials = assumed_role_object["Credentials"]

    return boto3.Session(
        aws_access_key_id=credentials["AccessKeyId"],
        aws_secret_access_key=credentials["SecretAccessKey"],
        aws_session_token=credentials["SessionToken"],
    )


def get_all_aws_accounts(role_suffix="developer"):
    for account_id, account_name in WELLCOME_ACCOUNT_NAMES.items():
        sess = get_aws_session(
            role_arn=f"arn:aws:iam::{account_id}:role/{account_name}-{role_suffix}"
        )

        yield account_id, account_name, sess
