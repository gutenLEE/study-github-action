function makeSignature() {
	nl=$'\\n'

	TIMESTAMP=$(echo $(($(date +%s%N)/1000000)))
	ACCESSKEY=TOjd9WuQ3vsEaIfNGXhN
	SECRETKEY=k13ZLl8lNUozdXGBHdavSSBkMnnUyYMF3tHt0dK7

	METHOD="GET"
	URI="/vserver/v2/addAccessControlGroupInboundRule?regionCode=KR&vpcNo=132024&accessControlGroupNo=$ACCESSCONTROLGROUPNO&accessControlGroupRuleList.1.protocolTypeCode=TCP&accessControlGroupRuleList.1.ipBlock=***.***.0.0%2F0&accessControlGroupRuleList.1.portRange=8888"

	SIG="$METHOD"' '"$URI"${nl}
	SIG+="$TIMESTAMP"${nl}
	SIG+="$ACCESSKEY"

	SIGNATURE=$(echo -n -e "$SIG"|iconv -t utf8 |openssl dgst -sha256 -hmac $SECRETKEY -binary|openssl enc -base64)


	echo $SIGNATURE

	curl -i -X $METHOD \
		-H "Content-type: application/json" \
		-H "x-ncp-apigw-timestamp:$TIMESTAMP" \
		-H "x-ncp-iam-access-key:$ACCESSKEY" \
		-H "x-ncp-apigw-signature-v2:$SIGNATURE" \
		'https://ncloud.apigw.gov-ntruss.com/vserver/v2/addAccessControlGroupInboundRule?regionCode=KR&vpcNo=47309&accessControlGroupNo=132024&accessControlGroupRuleList.1.protocolTypeCode=TCP&accessControlGroupRuleList.1.ipBlock=0.0.0.0/0&accessControlGroupRuleList.1.portRange=8888'

}

token=$( makeSignature )
export TOKEN=$token