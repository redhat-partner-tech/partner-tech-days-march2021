#!/usr/bin/env bash 

# author: Laine Vyvyan (@lainie-ftw laine.vyvyan@gmail.com) and Josh Smith (@joshmsmith joshmsmith@gmail.com)

#Set up some variables
clusterrooturl="cluster-f0fe.f0fe.example.opentlc.com"
clusterapiurl="https://api.${clusterrooturl}:6443/"

appserverless="pl-serverless"
projectname="piglatin"

#Setting up some colors for helping read the demo output
#Using ${green}GREEN${reset} for UI pauses
#Using ${blue}BLUE${reset} for script steps

green=$(tput setaf 2)
blue=$(tput setaf 4)
purple=$(tput setaf 125)
reset=$(tput sgr0)

#Let's do this thing...
read -p "${green}Welcome to the Pig Latin Translator Serverless demo! Press enter to proceed. ${reset}"

read -p "${blue}Login to the cluster, create the piglatin project, and create the Slack App key secret.${reset}"
oc login ${clusterapiurl}
oc new-project ${projectname}
oc create secret generic slack-signing-secret --from-literal=SLACK_SIGNING_SECRET=--SLACK APP SECRET HERE--

#Deploy the Pig Latin application in the normal way
read -p "${green}We're going to deploy the Pig Latin application in the usual way, using the OpenJDK template in the catalog in the UI, and apply the secret to it.${green}"

#Change the Slack app slash command endpoint URL
read -p "${green}In the Slack App admin page, we'll verify that the endpoint URL matches what was deployed.${green}"

#Do the slash command
read -p "${green}...and then in Slack, we'll test out the slash command.${green}"
oc project knative-serving

#Install the serverless operator
read -p "${green}Okay, now let's *do this thing* (serverless!) - starting with installing the OpenShift Serverless operator.${green}"

#Deploy the same application serverless-ly
read -p "${green}We CAN deploy a Knative Service (ksvc) via the UI, but it takes a YAML file anyway and automation is cool, so we're going to do it that way instead.${reset}"

read -p "${blue}Apply the ksvc YAML file to deploy the application serverless-ly.${blue}"
cd ksvcs
oc apply -f pl-serverless.yaml

#Change the Slack app slash command endpoint URL
read -p "${green}In the Slack App admin page, we need to change the endpoint URL to hit the new serverless version of the application.${green}"

#Do the slash command - oh noes, no work!
read -p "${green}...and then in Slack, we'll test out the slash command.${green}"
 
#Change the serverless deployment to have a min number of replicas
read -p "${blue}Welp... Now, let's apply the ksvc YAML file again, but this time with a minimum number of replicas to leave running (no scale to zero).${blue}"
oc delete ksvc pl-serverless --wait
oc apply -f pl-serverless-minlimit.yaml

#Do the slash command
read -p "${green}...and then in Slack, we'll test out the slash command.${green}"

#Change the serverless deployment to have a hard concurrency limit of 1
read -p "${blue}SWEET. Now, let's tweak some things to watch the application scale up. We're going to adjust what's called the concurrency, which is a hard(ish) limit regarding how many requests each pod should manage. We're going to make it 1. ${blue}"
oc delete ksvc pl-serverless --wait
oc apply -f pl-serverless-hardlimit1.yaml

#Have people hit the endpoint/Slack command to try to generate load
read -p "${green}AUDIENCE PARTICIPATION TIME. Try the slash command in Slack, or use the curl command in the general channel in Slack, and try to make the application scale.${green}"

#Generate load via hey command
read -p "${blue}For a slightly more controlled test, we're going to use a binary called hey to generate load. We'll start with 30 seconds of constant traffic, with 5 requests.${blue}"
hey -z 30s -c 5 -m POST-H  'Content-Type: application/json' -d  '{"inputText":"hello"}' http://pl-serverless-piglatin.apps.cluster-f0fe.f0fe.example.opentlc.com/piglatin 

read -p "${blue}Now let's see what happens with 30 seconds of constant traffice, with 25 requests.${blue}"
hey -z 30s -c 25 -m POST -H  'Content-Type: application/json' -d  '{"inputText":"hello"}' http://pl-serverless-piglatin.apps.cluster-f0fe.f0fe.example.opentlc.com/piglatin

read -p "${green}Let's talk about this some more, back to the slides!${green}"
