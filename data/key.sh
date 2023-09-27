function makeSignature() {
	nl=$'\\n'

	TIMESTAMP=$(echo $(($(date +%s%N)/1000000)))
	ACCESSKEY=$ACCESSKEY
	SECRETKEY=$SECRETKEY

	METHOD="GET"
	URI="/vserver/v2/addAccessControlGroupInboundRule?regionCode=KR&vpcNo=$VPCNO&accessControlGroupNo=$ACCESSCONTROLGROUPNO&accessControlGroupRuleList.1.protocolTypeCode=TCP&accessControlGroupRuleList.1.ipBlock=$IP&accessControlGroupRuleList.1.portRange=8888"

	echo $IP

	SIG="$METHOD"' '"$URI"${nl}
	SIG+="$TIMESTAMP"${nl}
	SIG+="$ACCESSKEY"

	SIGNATURE=$(echo -n -e "$SIG"|iconv -t utf8 |openssl dgst -sha256 -hmac $SECRETKEY -binary|openssl enc -base64)


	echo $SIGNATURE

	curl --location 'https://ncloud.apigw.ntruss.com'$URI \
		--header "Content-type:application/json" \
		--header "x-ncp-apigw-timestamp:$TIMESTAMP" \
		--header "x-ncp-iam-access-key:$ACCESSKEY" \
		--header "x-ncp-apigw-signature-v2:$SIGNATURE"

}

token=$( makeSignature )