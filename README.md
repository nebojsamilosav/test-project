# test-project docs

Created an example of single branch infrastructure.

REPO STRUCTURE:

### .github/workflows/
- deploy-dev.yml    starts on PR
- deploy-stage.yml  manually triggered
- deploy-prod.yml   manually triggered
All environments have a approval step betwen terraform plan and terraform apply step.
This is to ensure plan is good and we wish to proceed.
And PROD could have an additional approver if we wish so.

*** Alernative method could be to have a single tf-plan.yml where on PR we run only terraform plan for all envs.
    And then have separate deploy stages to run terraform apply only.

### /env/
Here we have separate configs for all environments.
Changing the env variable the creates the appropriate resources with coresponding env name.
Here we only have the main.tf and backend.tf.
main.tf calls the underlynig "main" module, defines the env itself and is being used as source of variable values (so, no tfvars files).
The boolian variables used here determine which modules we want to use, sometimes we don not need all of them for all environmets.

### /modules/
In this case only the modules are created the EC2 and S3.
No code needs to be changed, all environmets use the same.
Could have separated the policy part to IAM module as well, but for simplicty leaved it where it is. 


So, now we have the environmets separated:
- each environment has separate terraform state file (same bucket, different path)
- naming prefixes (all resources have env name in the name of the resource)


BRANCHING

As mentiond before, all code is on the main branch.
Create new "feature" branch, work on code. On PR to main, workflow is automaticaly run on DEV.

1. DEV   - Merge PR if satisfied with the result of workflow
2. STAGE - Manualy trigger deploy in UI if satisfied with results of DEV testing 
3. PROD  - Manualy trigger deploy in UI if satisfied with results of STAGE testing
   On PROD we could add aditional approvals based on Environent "deployment protection rules" setting

RUNNING 

### CI/CD

- Create all environments dev/stage/prod
- Add variable to repo settings for all envs named ENVIRONMENT with corresponding values
- Add secrets AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY to repo or environment secrets
- also in the "approvers" step change the username "nebojsamilosav" to some other used by you on GitHub

### locally
- have AWS CLI and terraform installed
- configure AWS CLI credentials
- switch to needed environment folder 
  cd env/dev
- terraform init, plan, deploy as usual 
