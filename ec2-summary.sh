#!/bin/bash

# Sample
# aws ec2 describe-instances | jq -r ".Reservations[].Instances[] | {name: (.Tags[] | select(.Key == \"Name\").Value), privateIp: .PrivateIpAddress, publicIp: .PublicIpAddress}"

opt_oneline=${1}
if [ "${opt_oneline}" = "--short" ] || [ "${opt_oneline}" = "-s" ]
then
	jq_options="-c -r"
elif [ "${opt_oneline}" = "--long" ] || [ "${opt_oneline}" = "-l" ]
then
	jq_options="-r"
else
	jq_options="-c -r"
fi

jq_pattern_body=""
jq_pattern_body="${jq_pattern_body}name: (.Tags[] | select(.Key == \"Name\").Value)"
jq_pattern_body="${jq_pattern_body},instanceIid: .InstanceId"
jq_pattern_body="${jq_pattern_body},privateIp: .PrivateIpAddress"
jq_pattern_body="${jq_pattern_body},publicIp: .PublicIpAddress"

jq_pattern_head=".Reservations[].Instances[] | {"
jq_pattern_tail="}"
jq_pattern="${jq_pattern_head}${jq_pattern_body}${jq_pattern_tail}"

aws ec2 describe-instances |jq ${jq_options} "${jq_pattern}"

