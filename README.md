# Secrets and .env variables

For sensitiv data like access tokens, database URIs, passwords and more we use AWS Secret Manager as a central and secure storage. **NEVER upload sensitive data unencrypted to GitHub or others**.
<br /><br />

**Read the full tutorial in my [Medium Article](https://medium.com/@niklas_braun/a-developers-guide-storing-node-js-environment-variables-in-aws-secret-manager-d41a137399a0)**
<br /><br />

## Requirements

To use AWS Secret Manager you need a bunch of tools:

- [AWS CLI 2](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
  - Used for connecting to AWS Secret Manager
- [Homebrew](https://brew.sh) and [jq](https://formulae.brew.sh/formula/jq) installed
  - Great package manager for Mac OS
  - **jq** is used for processing JSON in command-line interface

If you just cloned the project for the first time, make sure your aws-cli is  
configured (`aws configure` command) and run

```shell
make setup
```

to fetch the required (development) secrets to your local machine.
<br /><br /><br />

## Info
In this project we are using `eu-central-1` as our AWS region. If you want to use another region you have to change `--region eu-central-1` to `--region YOUR-REGION-HERE` in `./aws-secrets/fetchSecretsLocally.sh`.

Also note that you change your secret id to the secret id you chose in AWS Secret Manager `--secret-id "YOUR_SECRET_ID"` in `./aws-secrets/fetchSecretsLocally.sh`.

<br /><br />
## Actions overview

| Command         | Description                                                                                                |
| :-------------- | :--------------------------------------------------------------------------------------------------------- |
| **make setup**  | Fetches Secrets and creates .env.development file with injected secrets if no .env.development file exists |
| **make update** | Updates created .env.development file with freshly fetched secrets from AWS Secret Manager                 |
| **make remove** | Removes .env.development                                                                                   |

---

<br /><br />

## How to add or remove environment variables and secrets

### Add environment variable

Edit the `.env.example` file and add the key and a placeholder value.<br /><br />

#### Example

You want to add a variable named **MY_NEW_VAR** with value **hello-world**<br /><br />
Your value must have the prefix **<PLACE\_** and suffix **\_HERE>**<br />
Example `.env.example`:

```shell
    MY_NEW_VAR=<PLACE_MY_NEW_VAR_HERE>
```

After you added the variable to the `.env.example` head into [AWS Management console](https://eu-central-1.console.aws.amazon.com/console/home) (eu-central-1) and navigate to `Secrets Manager`. Select the Secret you want to add the variable to (dev, stg, prod or all of them) and add the key and value. In this case add `MY_NEW_VAR` as the key and `hello-world` as value.<br/><br/>
Afterwards you can run `make update` or `make setup`

---

### Remove environment variable

1. Remove the variable and value from `.env.example`
2. Open [AWS Management console](https://eu-central-1.console.aws.amazon.com/console/home) (eu-central-1) in your browser and navigate to `Secrets Manager`
3. Select the environment you want to remove the variable from and remove it.
4. Run `make update` to update your `.env.development` file
5. If everything works fine create a branch and push code to GitHub and notify other developers. Otherwise we head into an inconsistant code base

---

<br /><br />

## Important Notes

1. Never implement secret values without the Secret Manager
2. Always make sure that you remove the correct variable from Secret Manager
3. Push your changes to GitHub and notify other developers
4. Choose the right AWS region when you use the AWS Management Console or configure you AWS CLI