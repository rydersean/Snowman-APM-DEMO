# snowman-APM-demo

Cloning this git repository will allow you to use terraform to deploy a micro GCP instance (Ubuntu 18.04.5 LTS) with the SplunkFx SmartAgent and a Nodejs instrumented application called Snowman. 

# Assumptions

* You have a GCP account
* You have terraform installed and working
* You have an active Splunk SignalFx account

# Adding permissions for terraform to create resources on GCP

Log into your GCP account > Choose a project from the dropdown or Create a new project > Give your project or name or accept the default > Create.

Now you need to create a service account. In the GCP dashboard > IAM & admin > Service accounts > CREATE SERVICE ACCOUNT > Service Account Name [terraform-sa] > Create > Select a role > Project > Editor > Continue > Create Key > Key Type [json] > Create.

Download your project key and place it in the secrets/ directory. Then change: credentials = file("secrets/My_Project_7847-b6797c6771e2.json") to your project json filename in the main.tf file.

# Deploying with terraform

You can add your token before deploying through terraform (recommended) by changing "ENTER_YOUR_TOKEN_HERE" to your token key in the scripts/installSnowmanSignalFxSmartAgent.txt file.

$ terraform init

$ terraform apply

Answer 'yes' to deploy.

If you want to add your token after deploying with terraform, add your token to "ENTER_YOUR_TOKEN_HERE" in the /etc/signalfx/agent.yaml file. In this case you would need to restart your smartagent with the command:

$ systemctl restart signalfx-agent.service

# Getting snowman running

There will be a file in the $HOME of the root user with instructions to clone and start the snowman game.

 $ sudo su
 
 $ cat ~/snowman.txt

You should see the following
# clone snowman from git repo

git clone https://github.com/rydersean/tracing-examples

cd tracing-examples/signalfx-tracing/signalfx-nodejs-tracing/express

# Run the server in one terminal

npm install

npm start

# Run the client in another terminal

npm run client new

npm run client guess x

---

Once you have tried to guess the word (successfully or not) you can check Splunk SignalFx dashboard > APM > you should see your service snowman. Go to the troubleshooting tab > Show Traces and click on one of your trace ID links to inspect that trace and its spans.

---

# Cleaning up when you are done'

When you are done playing the snowman game and you have learn't what you need with SplunkFx APM, you can destroy your deployment using the following command.

$ terraform destroy

Answer 'yes' to destroy the environment.
