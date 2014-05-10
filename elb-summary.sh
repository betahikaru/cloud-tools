#!/bin/bash

# Sample
# aws elb describe-load-balancers | jq -r ".LoadBalancerDescriptions[] | {name: .LoadBalancerName, hostedZoneId: .CanonicalHostedZoneNameID, hostedZoneName: .CanonicalHostedZoneName, instances: .Instances}"

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
jq_pattern_body="${jq_pattern_body}name: .LoadBalancerName"
jq_pattern_body="${jq_pattern_body},hostedZoneId: .CanonicalHostedZoneNameID"
jq_pattern_body="${jq_pattern_body},hostedZoneName: .CanonicalHostedZoneName"
jq_pattern_body="${jq_pattern_body},instances: .Instances"

jq_pattern_head=".LoadBalancerDescriptions[] | {"
jq_pattern_tail="}"
jq_pattern="${jq_pattern_head}${jq_pattern_body}${jq_pattern_tail}"

aws elb describe-load-balancers | jq ${jq_options} "${jq_pattern}"

